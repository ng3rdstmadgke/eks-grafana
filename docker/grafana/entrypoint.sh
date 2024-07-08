#!/bin/bash
set -e


# プラグインのインストールは冪等性を持たせること！
grafana cli plugins install redis-datasource 2.2.0
grafana cli plugins install grafana-clock-panel 1.0.1
grafana cli plugins install grafana-mqtt-datasource

GRAFANA_PLOTLY_PANEL_PLUGIN_DIR=$GF_PATHS_PLUGINS/NatelEnergy-grafana-plotly-panel-e8bc9e9
if [ ! -r "$GRAFANA_PLOTLY_PANEL_PLUGIN_DIR/plugin.json" ]; then
  mkdir -p $GRAFANA_PLOTLY_PANEL_PLUGIN_DIR
  wget "https://github.com/NatelEnergy/grafana-plotly-panel/releases/download/v0.0.6/natel-plotly-panel-0.0.6.zip" -P /tmp
  unzip /tmp/natel-plotly-panel-0.0.6.zip -d $GRAFANA_PLOTLY_PANEL_PLUGIN_DIR
fi

# デフォルトの起動コマンド
/run.sh