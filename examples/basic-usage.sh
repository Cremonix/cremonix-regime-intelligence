#!/usr/bin/env bash
# Basic usage example for Cremonix Signals skill

echo "🔍 Fetching Cremonix signals..."
echo ""

# Fetch the feed
response=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json")

# Parse key data
btc_regime=$(echo "$response" | jq -r '.btc.regime_4h')
eth_regime=$(echo "$response" | jq -r '.eth.regime_4h')
btc_setup=$(echo "$response" | jq -r '.btc.setup.exists')
eth_setup=$(echo "$response" | jq -r '.eth.setup.exists')

# Display results
echo "📊 Market Regimes:"
echo "  BTC (4h): $btc_regime"
echo "  ETH (4h): $eth_regime"
echo ""

echo "🎯 ML Setups:"
if [ "$btc_setup" == "true" ]; then
  combo=$(echo "$response" | jq -r '.btc.setup.combo_id')
  score=$(echo "$response" | jq -r '.btc.setup.score')
  echo "  BTC: $combo (score: $score) ✅"
else
  echo "  BTC: No setup detected"
fi

if [ "$eth_setup" == "true" ]; then
  combo=$(echo "$response" | jq -r '.eth.setup.combo_id')
  score=$(echo "$response" | jq -r '.eth.setup.score')
  echo "  ETH: $combo (score: $score) ✅"
else
  echo "  ETH: No setup detected"
fi

echo ""
echo "💡 Tip: Upgrade to paid tier for real-time signals at app.cremonix.com/api-subscribe"
