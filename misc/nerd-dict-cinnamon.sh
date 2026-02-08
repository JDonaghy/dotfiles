#!/bin/bash
mkdir -p $HOME/src
cd $HOME/src

if [ ! -d $HOME/src/nerd-dictation ]; then
  git clone https://github.com/ideasman42/nerd-dictation.git
  pushd nerd-dictation
  python3 -m venv venv
  source venv/bin/activate
  pip install vosk

  python3 -m venv venv
  source venv/bin/activate
  pip install vosk
  deactivate
  popd
fi

mkdir -p $HOME/.config/nerd-dictation

if [ ! -d $HOME/.config/nerd-dictation/model ]; then
  pushd $HOME/.config/nerd-dictation
  wget https://alphacephei.com/kaldi/models/vosk-model-small-en-us-0.15.zip\n
  unzip vosk-model-small-en-us-0.15.zip
  mv vosk-model-small-en-us-0.15 model
  popd
fi

TEMP_CONF="/tmp/cinnamon_kb_full.dconf"
dconf dump /org/cinnamon/desktop/keybindings/ > "$TEMP_CONF"

if grep -q "start nerd-dictation" "$TEMP_CONF"; then
    echo "Shortcuts already exist. Skipping."
    rm "$TEMP_CONF"
    exit 0
fi

COUNT=$(echo "$TEMP_CONF" | grep "custom-list" | grep -oP "'\Kcustom\d+" | wc -l)
IDX1="custom$COUNT"
IDX2="custom$((COUNT + 1))"

if grep -q "custom-list=" "$TEMP_CONF"; then
    sed -i "s|custom-list=\[\(.*\)\]|custom-list=\[\1, '$IDX1', '$IDX2'\]|" "$TEMP_CONF"
    sed -i "s/\[, /\[/g" "$TEMP_CONF"
else
    {
      echo "[/]"
      echo ""
      echo "custom-list=['$IDX1', '$IDX2']"
      echo ""
      cat "$TEMP_CONF"
    } > "${TEMP_CONF}.new"
    mv "${TEMP_CONF}.new" "$TEMP_CONF"
fi

cat <<EOF >> "$TEMP_CONF"

[custom-keybindings/$IDX1]
binding=['<Alt>x']
command='$HOME/src/nerd-dictation/venv/bin/python3 $HOME/src/nerd-dictation/nerd-dictation begin'
name='start nerd-dictation'

[custom-keybindings/$IDX2]
binding=['<Alt>z']
command='$HOME/src/nerd-dictation/venv/bin/python3 $HOME/src/nerd-dictation/nerd-dictation end'
name='stop nerd-dictation'
EOF


dconf load /org/cinnamon/desktop/keybindings/ < "$TEMP_CONF"

rm "$TEMP_CONF"
echo "Successfully added $IDX1 and $IDX2."

