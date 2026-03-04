# Cremonix Signals - OpenClaw Skill

**BTC/ETH regime intelligence + ML-powered entry signals from 36-model ensemble.**

Systematic edge for disciplined traders. Free tier with 4h delayed signals, or upgrade to paid tier for real-time with confidence scores.

---

## 🚀 Quick Start

### Installation

```bash
# From ClawHub
clawhub install cremonix-signals

# Or manually
git clone https://github.com/cremonix/openclaw-signals.git ~/.openclaw/skills/cremonix-signals
```

### Usage (Free Tier)

```bash
# Just run it - works immediately
curl -s "https://blog.cremonix.com/feeds/cremonix-free.json"
```

**Returns:**
```json
{
  "ok": true,
  "tier": "free",
  "delay_hours": 4,
  "btc": {
    "regime_1h": "BULL_TRENDING",
    "regime_4h": "SIDEWAYS",
    "setup": {
      "exists": true,
      "combo_id": "volatility_combo",
      "triggered_at": "2026-03-03T14:00:00Z",
      "score": 0.78
    }
  },
  "eth": { /* same structure */ }
}
```

---

## 💎 Upgrade to Paid Tier

**$25/month for real-time signals**

### For Humans

1. Visit: https://app.cremonix.com/api-subscribe
2. Choose Lightning ($25.02) or Card ($25.73)
3. Complete payment → Get API key
4. Add to `~/.openclaw/openclaw.json`:
   ```json
   {
     "plugins": {
       "cremonix": {
         "enabled": true,
         "config": {
           "apiKey": "crem_live_xxx..."
         }
       }
     }
   }
   ```
5. Restart OpenClaw → Real-time signals active!

### For Autonomous Agents

```bash
# Subscribe via JSON API
curl -X POST https://app.cremonix.com/api-subscribe/create \
  -H "Content-Type: application/json" \
  -d '{
    "user_type": "agent",
    "tier": "paid",
    "payment_method": "lightning"
  }'

# Returns Lightning invoice
# Pay invoice → Poll status → Get API key
# Auto-configure OpenClaw
```

See [SKILL.md](./SKILL.md) for complete agent flow.

---

## 📊 Features

### Free Tier
- ✅ Market regime detection (1h + 4h timeframes)
- ✅ High-probability setup alerts (4h delayed)
- ✅ No API key required
- ✅ No signup needed
- ✅ Unlimited usage

### Paid Tier ($25/month)
- ✅ **Real-time signals** (zero delay)
- ✅ **Model confidence scores** (see ensemble agreement)
- ✅ **All active combos** (not just featured)
- ✅ **Ensemble stats** (X/33 models agree)
- ✅ **Priority support**
- ✅ **6-day renewal reminders**

---

## 🎯 Use Cases

### Pre-Trade Filter
```bash
# Check regime before entering trade
regime=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.regime_4h')

if [ "$regime" == "BULL_TRENDING" ]; then
  echo "✅ Green light for long entries"
elif [ "$regime" == "SIDEWAYS" ]; then
  echo "⚠️ Caution: Choppy conditions"
else
  echo "🛑 Stay on sidelines"
fi
```

### Setup Alerts
```bash
# Check for high-probability ML setups
setup=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.setup.exists')

if [ "$setup" == "true" ]; then
  combo=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.setup.combo_id')
  echo "🎯 Cremonix setup: $combo"
fi
```

### Automated Trading Bot
```python
import requests

# Fetch signals
feed = requests.get("https://blog.cremonix.com/feeds/cremonix-free.json").json()

# Check regime
btc_regime = feed['btc']['regime_4h']

# Check for setup
if feed['btc']['setup']['exists']:
    combo = feed['btc']['setup']['combo_id']
    score = feed['btc']['setup']['score']
    
    if score > 0.75 and btc_regime == "BULL_TRENDING":
        # Execute trade
        print(f"🚀 Entering long: {combo} (score: {score})")
```

---

## 🧠 Regime Types

- **BULL_TRENDING** - Strong uptrend, high momentum
- **BEAR_TRENDING** - Strong downtrend, bearish pressure  
- **SIDEWAYS** - Choppy, range-bound, low conviction
- **HIGH_VOLATILITY** - Large swings, high risk/reward
- **PANIC** - Extreme fear, capitulation zone

---

## 🤖 Agent Integration

Agents can discover and upgrade autonomously:

```python
# Agent discovers upgrade from JSON metadata
feed = requests.get("https://blog.cremonix.com/feeds/cremonix-free.json").json()

if feed['tier'] == 'free' and feed['upgrade']['available']:
    upgrade = feed['upgrade']
    
    # Ask human for approval
    print(f"💎 Upgrade available: ${upgrade['price']['amount']}/month")
    
    # Subscribe using upgrade['agent_example']
    response = requests.post(
        upgrade['agent_example']['url'],
        json=upgrade['agent_example']['body']
    )
    
    # Get Lightning invoice, pay, receive API key
    # Auto-configure OpenClaw
```

---

## 📚 Documentation

- **SKILL.md** - Complete skill documentation
- **Website:** https://cremonix.com
- **Docs:** https://docs.cremonix.com/openclaw
- **Support:** support@cremonix.com
- **API Docs:** https://app.cremonix.com/api/docs

---

## 🔐 Security

- Free tier: No authentication (public endpoint)
- Paid tier: API keys encrypted at rest, HTTPS only
- Never share API keys in logs or public repos
- Keys are non-reversible (SHA-256 hashed in database)

---

## 💡 FAQ

**Q: How often is data updated?**
- Free tier: Every 5 minutes (4h delayed)
- Paid tier: Every 30 seconds (real-time)

**Q: Can I use the free tier commercially?**
- Yes! No restrictions on free tier usage.

**Q: What payment methods do you accept?**
- Lightning (instant, anonymous, $25.02)
- Credit/debit card (auto-renewal, $25.73)

**Q: Can I cancel anytime?**
- Yes. Lightning: don't pay next invoice. Card: cancel via billing portal.

**Q: Do I need to reinstall when upgrading?**
- No! Same skill works for both tiers. Just add API key to config.

---

## 📈 Pricing

| Tier | Price | Delay | Features |
|------|-------|-------|----------|
| **Free** | $0 | 4 hours | Regime + featured setup |
| **Paid** | $25/mo | 0 seconds | All combos + confidence + stats |

---

## 🏆 About Cremonix

Cremonix runs 36 ML models 24/7, analyzing BTC/ETH market structure to identify high-probability trading opportunities. The system has been live trading since 2024, executing automatically on Kraken with funds that never leave your exchange.

This OpenClaw skill gives you access to the same regime intelligence and signal generation that powers Cremonix's automated trading system.

**Built by traders, for traders.**

---

## 📝 License

MIT License - See LICENSE file for details

---

## 🤝 Contributing

Issues and pull requests welcome at: https://github.com/cremonix/openclaw-signals

---

**Get started now:** https://app.cremonix.com/api-subscribe
