{
  bc,
  fetchFromGitHub,
  hyprcursor,
  jq,
  ripgrep,
  stdenv,
  writeText,
}:

let
  manifestTemplate = writeText "manifest.hl.template" ''
    name = phinger-cursors-@variant@
    description = Most likely the most over engineered cursor theme.
    version = @version@
    cursors_directory = cursors
  '';

  metaTemplate = writeText "meta.hl.template" ''
    resize_algorithm = none
    hotspot_x = @hotspotX@
    hotspot_y = @hotspotY@
    define_override = @cursorName@
  '';
in

stdenv.mkDerivation (finalAttrs: {
  pname = "phinger-cursors-hyprcursor";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "phisch";
    repo = "phinger-cursors";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jcWfxbMT5GXvB3COJFBONcLqG5tJBfD682wydfuRjm8=";
  };

  nativeBuildInputs = [
    bc
    hyprcursor
    jq
    ripgrep
  ];

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    cursorDir=hyprcursor
    mkdir -p $cursorDir/{dark,light}/cursors

    cursorThemeJson=theme/cursor-theme.json
    variants=("dark" "light")

    for i in ''${!variants[@]}; do
      variant=''${variants[$i]}
      substitute ${manifestTemplate} $cursorDir/$variant/manifest.hl \
        --subst-var variant \
        --subst-var version

      numCursors=$(jq ".variants[$i].cursors | length" $cursorThemeJson)
      for j in $(seq 0 $(($numCursors - 1))); do
        cursorFileName=$(jq -r ".variants[$i].cursors[$j].sprites[0].file" $cursorThemeJson | cut -f2 -d'/')
        cursorFilePath=theme/$variant/$cursorFileName
        cursorName=$(jq -r ".variants[$i].cursors[$j].name" $cursorThemeJson)

        origX=$(rg "<rect id=\"center" $cursorFilePath | rg -Po '(?<= x=\")([0-9]*)' || echo 0)
        origY=$(rg "<rect id=\"center" $cursorFilePath | rg -Po '(?<= y=\")([0-9]*)' || echo 0)
        hotspotX=$(echo "scale=1; $origX/24" | bc -l | awk '{printf "%.1f\n", $0}')
        hotspotY=$(echo "scale=1; $origY/24" | bc -l | awk '{printf "%.1f\n", $0}')

        currentCursorDir=$cursorDir/$variant/cursors/$cursorName
        mkdir -p $currentCursorDir

        substitute ${metaTemplate} "$currentCursorDir/meta.hl" \
          --subst-var cursorName \
          --subst-var hotspotX \
          --subst-var hotspotY

        if [[ $(jq -r ".variants[$i].cursors[$j].sprites[0].animations // empty") != "" ]]; then
          centerX=$(awk -f ${./center-x.awk} $cursorFilePath)
          centerY=$(awk -f ${./center-y.awk} $cursorFilePath)

          rotationDegrees=$(jq -r ".variants[$i].cursors[$j].sprites[0]
            .animations[0].instructions[1].args.degrees" $cursorThemeJson)

          duration=$(jq -r ".variants[$i].cursors[$j].sprites[0]
            .animations[0].instructions[0].args.duration" $cursorThemeJson)

          ease=$(jq -r ".variants[$i].cursors[$j].sprites[0]
            .animations[0].instructions[0].args.ease" $cursorThemeJson)

          totalFrames=60
          if [[ $ease == "in-out-cubic" ]]; then
            for k in $(seq 0 $((totalFrames - 1))); do
              t=$(echo "scale=6; $k/($totalFrames/2)" | bc -l)
              if [[ $(echo "scale=6; $t < 1" | bc -l) -eq 1 ]]; then
                frameStartDegree=$(echo "scale=6; $rotationDegrees/2*$t*$t*$t" | bc -l)
              else
                t=$(echo "scale=6; $t-2" | bc -l)
                frameStartDegree=$(echo "scale=6; $rotationDegrees/2*($t*$t*$t + 2)" | bc -l)
              fi

              cursorFrameFilePath=$currentCursorDir/$k_$cursorFileName
              awk -v centerx=$centerX -v centery=$centerY -v angleDeg=$frameStartDegree \
                -f ${./rotate-circle.awk} $cursorFilePath > $cursorFrameFilePath

              awk -f ${./remove-hotspot-rect.awk} $cursorFrameFilePath > $cursorFrameFilePath.tmp &&
                mv $cursorFrameFilePath.tmp $cursorFrameFilePath

              echo "define_size = 0, $cursorFrameFilePath, $(echo "scale=3; $duration/$totalFrames" | bc -l)" \
                > $currentCursorDir/meta.hl
            done
          fi
        else
          awk -f ${./remove-hotspot-rect.awk} $cursorFilePath > $currentCursorDir/$cursorFileName
          echo "define_size = 0, $cursorFileName" >> $currentCursorDir/meta.hl
        fi
      done
    done

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    for variant in "dark" "light"; do
      hyprcursor-util --create $cursorDir/$variant --output $out/share/icons
    done

    runHook postInstall
  '';

  # installPhase = ''
  #   runHook preInstall

  #   set -euo pipefail

  #   mkdir -p ./hyprcursor/{dark/cursors,light/cursors}
  #   local CURSORDIR; CURSORDIR="$(pwd ./hyprcursor)/hyprcursor"
  #   local JSON; JSON="$(< ./theme/cursor-theme.json)"

  #   pushd theme || exit

  #   # for every theme listed in cursor-theme.json
  #   for i in $(seq 0 "$(( $(jq '.variants | length' cursor-theme.json) - 1 ))"); do

  #     local currentTheme; currentTheme="$(jq -r ".variants[$i].name" <<< "$JSON")"
  #     pushd "$currentTheme" || exit

  #     # generate Hyprcursor manifest
  #     echo -en "
  #   name = phinger-cursors-$currentTheme
  #   description = Most likely the most over engineered cursor theme.
  #   version = ${version}
  #   cursors_directory = cursors
  #     " > "$CURSORDIR/$currentTheme/manifest.hl"

  #     # loop over all the cursors of this theme & create meta.hl for every single one
  #     for c in $(seq 0 "$(( $(jq ".variants[$i].cursors | length" <<< "$JSON") - 1 ))"); do

  #       # get the name of the current cursor
  #       local cursorName; cursorName="$(jq -r ".variants[$i].cursors[$c].name" <<< "$JSON")"
  #       # get the SVG filename without the [light|dark]/ prefix
  #       local cursorFile; cursorFile="$(jq -r ".variants[$i].cursors[$c].sprites[0].file" <<< "$JSON" | cut -d/ -f2)"

  #       # rg for the first SVG in sprites[] & get the hotspot
  #       local hotspot_x; hotspot_x="$(rg "<rect id=\"center" "$cursorFile" | rg -Po '(?<= x=\")([0-9]*)' || echo 0)"
  #       local hotspot_y; hotspot_y="$(rg "<rect id=\"center" "$cursorFile" | rg -Po '(?<= y=\")([0-9]*)' || echo 0)"

  #       # check if this cursor is animated
  #       if [[ "$(jq -r ".variants[$i].cursors[$c].sprites[0].animations" <<< "$JSON")" != "null" ]]; then

  #         # cursor is animated
  #         # create output dir for this cursor
  #         mkdir -p "$CURSORDIR/$currentTheme/cursors/$cursorName"
  #         # create meta.hl for this SVG under CURSORDIR
  #         echo -en "
  #   resize_algorithm = none
  #   hotspot_x = $(echo "scale=1; $hotspot_x/24" | bc -l | awk '{printf "%.1f\n", $0}')
  #   hotspot_y = $(echo "scale=1; $hotspot_y/24" | bc -l | awk '{printf "%.1f\n", $0}')
  #   define_override = $cursorName
  #   " > "$CURSORDIR/$currentTheme/cursors/$cursorName/meta.hl"

  #         # calculate center of the circle to animate (sum of all x coordinates of the moveto commands for the circle paths divided by their count)
  #         local centerx; centerx="$(awk 'BEGIN{sum=0;count=0}match($0, /id="Vector(_[0-9]*)?" d="M[0-9.]*/){match($0,/M[0-9\.]+/);count+=1;sum+=substr($0,RSTART+1,RLENGTH)}END{print sum/count}' "$cursorFile")"
  #         local centery; centery="$(awk 'BEGIN{sum=0;count=0}match($0, /id="Vector(_[0-9]*)?" d="M[0-9.]* [0-9.]*/){match($0,/ [0-9\.]+/);count+=1;sum+=substr($0,RSTART+1,RLENGTH)}END{print sum/count}' "$cursorFile")"
  #         # get the angle, duration & ease from the json file
  #         local rotationDegrees; rotationDegrees="$(jq -r ".variants[$i].cursors[$c].sprites[0].animations[0].instructions[1].args.degrees" <<< "$JSON")"
  #         local duration; duration="$(jq -r ".variants[$i].cursors[$c].sprites[0].animations[0].instructions[0].args.duration" <<< "$JSON")"
  #         local totalFrames; totalFrames=60
  #         local ease; ease="$(jq -r ".variants[$i].cursors[$c].sprites[0].animations[0].instructions[0].args.ease" <<< "$JSON")"

  #         if [[ "$ease" != "in-out-cubic" ]]; then
  #           echo "Found unsupported ease function $ease, skipping $cursorName"
  #           continue
  #         fi

  #         # create all the frames, rotating part of the SVG slightly with every frame
  #         for f in $(seq 0 $((totalFrames - 1))); do
  #           # calculate rotation for the current frame using an in-out-cubic ease function
  #           # largely copied from https://github.com/b3nson/sh.ease
  #           local t; t=$(echo "scale=6; $f/($totalFrames/2)" | bc -l)
  #           if [[ "$(echo "scale=6; $t < 1" | bc -l)" -eq 1 ]]; then
  #             # in phase
  #             local frameStartDegree; frameStartDegree=$(echo "scale=6; $rotationDegrees/2*$t*$t*$t" | bc -l)
  #           else
  #             # out phase
  #             local t; t=$(echo "scale=6; $t-2" | bc -l)
  #             local frameStartDegree; frameStartDegree=$(echo "scale=6; $rotationDegrees/2*($t*$t*$t + 2)" | bc -l)
  #           fi

  #           # do the magic (rotate the circle) (yes this is a 1300 character awk script in one line, cope) (see ./awk for a more readable version)
  #           awk -v centerx="$centerx" -v centery="$centery" -v angleDeg="$frameStartDegree" 'BEGIN{angleDeg=angleDeg;angleRad=angleDeg % 360 * (3.141592 / 180);centerx=centerx;centery=centery;FS="[C]";OFS="C";}/<path id="(Vector|Vector_[0-9])" d=/ {v=1;}!v{print;}v{mcommand=substr($1,match($1,/M/));split(mcommand,mvals," |M");mnewvals="";mnewvals=mnewvals " " (mvals[2] - centerx) * cos(angleRad) - (mvals[3] - centery) * sin(angleRad) + centerx;mnewvals = mnewvals " " (mvals[3] - centery) * cos(angleRad) + (mvals[2] - centerx) * sin(angleRad) + centery;sub(/([0-9]+(\.[0-9]+)? )+([0-9]+(\.[0-9]+)?)/,mnewvals,$1);for(i=2;i<=NF;i++){if(i>9){break;}split($i,cvals," |Z");newvals="";newvals=newvals " " (cvals[1] - centerx) * cos(angleRad) - (cvals[2] - centery) * sin(angleRad) + centerx;newvals=newvals " " (cvals[2] - centery) * cos(angleRad) + (cvals[1] - centerx) * sin(angleRad) + centery;newvals=newvals " " (cvals[3] - centerx) * cos(angleRad) - (cvals[4] - centery) * sin(angleRad) + centerx;newvals=newvals " " (cvals[4] - centery) * cos(angleRad) + (cvals[3] - centerx) * sin(angleRad) + centery;newvals=newvals " " (cvals[5] - centerx) * cos(angleRad) - (cvals[6] - centery) * sin(angleRad) + centerx;newvals=newvals " " (cvals[6] - centery) * cos(angleRad) + (cvals[5] - centerx) * sin(angleRad) + centery;sub(/([0-9]+(\.[0-9]+)? )+([0-9]+(\.[0-9]+)?)/,newvals,$i);}print $0;v=0;}' "$cursorFile" > "''${f}_$cursorFile"

  #           # remove the hotspot rectangle from the SVG (area between "<g id="hotspot"..." & "</g>", appears as a red dot)
  #           #                  V check for this regex              if found -> state=1 & next V       check V      V found&if(state==1)->state=0;next   V if state==0 -> print
  #           awk 'BEGIN{state=0}/<g id="hotspot" clip-path="url\(#clip[0-9]+_[0-9]+_[0-9]+\)">/{state=1;next}/<\/g>/{if(state){state=0;next}}!state{print}' "''${f}_$cursorFile" > tmp && mv tmp "''${f}_$cursorFile"
  #           # copy the SVG to CURSORDIR
  #           cp "''${f}_$cursorFile" "$CURSORDIR/$currentTheme/cursors/$cursorName/"

  #           # append cursor size w/ timeout to meta.hl
  #           echo -en "
  #   define_size = 0, ''${f}_$cursorFile, $(echo "scale=3; $duration/$totalFrames" | bc -l)" >> "$CURSORDIR/$currentTheme/cursors/$cursorName/meta.hl"

  #         done

  #         echo "" >> "$CURSORDIR/$currentTheme/cursors/$cursorName/meta.hl"

  #       else

  #         # cursor is not animated
  #         # copy the SVG to CURSORDIR
  #         mkdir -p "$CURSORDIR/$currentTheme/cursors/$cursorName"
  #         # remove the hotspot rectangle from the SVG (area between "<g id="hotspot"..." & "</g>", appears as a red dot)
  #         #                  V check for this regex             if found -> state=1 & next V       check V      V found: if state==1->state=0;next   V if state==0 -> print
  #         awk 'BEGIN{state=0}/<g id="hotspot" clip-path="url\(#clip[0-9]+_[0-9]+_[0-9]+\)">/{state=1;next}/<\/g>/{if(state){state=0;next}}!state{print}' "$cursorFile" > tmp && mv tmp "$cursorFile"
  #         cp "$cursorFile" "$CURSORDIR/$currentTheme/cursors/$cursorName/"

  #         # create meta.hl for this SVG under CURSORDIR
  #         echo -en "
  #   resize_algorithm = none
  #   hotspot_x = $(echo "scale=1; $hotspot_x/24" | bc -l | awk '{printf "%.1f\n", $0}')
  #   hotspot_y = $(echo "scale=1; $hotspot_y/24" | bc -l | awk '{printf "%.1f\n", $0}')
  #   define_override = $cursorName
  #   define_size = 0, $cursorFile
  #         " > "$CURSORDIR/$currentTheme/cursors/$cursorName/meta.hl"

  #       fi

  #     done

  #     # make sure output dir exists
  #     mkdir -p "$out/share/icons/"

  #     # compile current Hyprcursor theme
  #     hyprcursor-util --create "$CURSORDIR/$currentTheme/" --output "$out/share/icons"

  #     popd || exit

  #   done;

  #   popd || exit

  #   runHook postInstall
  # '';
})
