#!/usr/bin/env bash
# Pre-trade filter example - Check regime before entering trades

ASSET=${1:-BTC}  # Default to BTC, or pass ETH as argument

echo "🔍 Checking $ASSET regime before trade entry..."
echo ""

# Fetch signals
response=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json")

# Get regime based on asset
if [ "$ASSET" == "BTC" ]; then
  regime=$(echo "$response" | jq -r '.btc.regime_4h')
  setup=$(echo "$response" | jq -r '.btc.setup.exists')
else
  regime=$(echo "$response" | jq -r '.eth.regime_4h')
  setup=$(echo "$response" | jq -r '.eth.setup.exists')
fi

echo "📊 $ASSET Regime (4h): $regime"
echo ""

# Decision logic
if [ "$regime" == "BULL_TRENDING" ]; then
  echo "✅ GREEN LIGHT: Strong uptrend"
  echo "   → Safe to consider long entries"
  echo "   → High probability of continuation"
  
  if [ "$setup" == "true" ]; then
    echo "   → 🎯 ML setup detected - high conviction!"
  fi
  
  exit 0
  
elif [ "$regime" == "BEAR_TRENDING" ]; then
  echo "🔴 RED LIGHT: Strong downtrend"
  echo "   → Avoid long entries"
  echo "   → Consider short positions only"
  exit 1
  
elif [ "$regime" == "SIDEWAYS" ]; then
  echo "⚠️  YELLOW LIGHT: Choppy conditions"
  echo "   → Trade with caution"
  echo "   → Reduce position size"
  echo "   → Tighten stops"
  
  if [ "$setup" == "true" ]; then
    echo "   → ML setup exists, but lower conviction in chop"
  fi
  
  exit 2
  
elif [ "$regime" == "HIGH_VOLATILITY" ]; then
  echo "⚡ ORANGE LIGHT: High volatility"
  echo "   → Expect large swings"
  echo "   → Widen stops or reduce size"
  echo "   → High risk / high reward"
  exit 3
  
else
  echo "🛑 UNKNOWN REGIME: $regime"
  echo "   → Data may be unavailable"
  exit 4
fi
