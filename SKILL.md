---
name: cremonix-signals
version: 1.0.0
description: "BTC/ETH regime intelligence + ML-powered entry signals from 36-model ensemble. Systematic edge for disciplined traders. Free: 4h delayed signals | Paid: real-time with confidence scores & model agreement."
author: Cremonix
homepage: https://cremonix.com
repository: https://github.com/cremonix/openclaw-signals
support: support@cremonix.com
license: MIT
---

# Cremonix Trading Signals

Get BTC/ETH market regime detection and ML-powered trading signals from Cremonix's 36-model ensemble.

## 🆓 Free Tier (No Setup)

This skill works immediately - no API key needed!

**What you get:**
- Market regime detection (1h + 4h timeframes)
- High-probability setups (4-hour delayed)
- Know when to trade and when to sit out

**Usage:**
```bash
curl -s "https://blog.cremonix.com/feeds/cremonix-free.json"
```

**Example output:**
```json
{
  "ok": true,
  "delay_hours": 4,
  "btc": {
    "regime_1h": "BULL_TRENDING",
    "regime_4h": "SIDEWAYS",
    "setup": {
      "exists": true,
      "combo_id": "volatility_combo",
      "triggered_at": "2026-03-03T13:00:00Z",
      "published_at": "2026-03-03T17:00:00Z",
      "score": 0.78
    }
  },
  "eth": { /* same structure */ }
}
```

---

## 💎 Paid Tier - Real-Time Signals

**Upgrade for:**
- ✅ **Real-time signals** (zero delay, not 4 hours)
- ✅ **Model confidence scores** (see ensemble agreement)
- ✅ **All active combos** (not just featured one)
- ✅ **Priority support**

**Price:** $25/month

### Step 1: Subscribe

Visit: **https://app.cremonix.com/api-subscribe**

Choose payment:
- ⚡ **Lightning** (instant, anonymous, $25.02) - Recommended for crypto users
- 💳 **Card** (auto-renewal, $25.73) - Set it and forget it

### Step 2: Get API Key

After payment, you'll receive:
```
API Key: crem_live_a3f9x2k8h5j2m9n4p7q1r6s3t8u2v5w7
```

### Step 3: Configure OpenClaw

Add to `~/.openclaw/openclaw.json`:

```json
{
  "plugins": {
    "cremonix": {
      "enabled": true,
      "config": {
        "apiKey": "crem_live_a3f9x2k8h5j2m9n4p7q1r6s3t8u2v5w7"
      }
    }
  }
}
```

**Or set environment variable:**
```bash
export CREMONIX_API_KEY="crem_live_..."
```

### Step 4: Restart OpenClaw

```bash
# If running as service
sudo systemctl restart openclaw

# Or just restart your agent
```

---

## 🔧 Usage (Works for Both Free & Paid)

### Basic Usage

```bash
# If you have API key configured, you get real-time
# If not, you get free (4h delayed)
curl -s "https://blog.cremonix.com/feeds/cremonix-free.json"
```

### With API Key (Paid)

```bash
curl -H "Authorization: Bearer $CREMONIX_API_KEY" \
  "https://app.cremonix.com/api/signals"
```

**Returns:**
```json
{
  "ok": true,
  "delay_hours": 0,  // <-- Real-time!
  "btc": {
    "regime_1h": "BULL_TRENDING",
    "regime_4h": "SIDEWAYS",
    "setup": {
      "exists": true,
      "combo_id": "volatility_combo",
      "triggered_at": "2026-03-03T17:02:45Z",  // <-- 2 minutes ago!
      "published_at": "2026-03-03T17:02:45Z",
      "score": 0.78,
      "confidence": 0.87,  // <-- Model confidence (paid only)
      "models_agree": 28,  // <-- 28/33 models agree (paid only)
      "models_total": 33
    }
  },
  "eth": { /* same structure */ }
}
```

---

## 📊 Regime Types

- **BULL_TRENDING** - Strong uptrend, high momentum
- **BEAR_TRENDING** - Strong downtrend, bearish pressure
- **SIDEWAYS** - Choppy, range-bound, low conviction
- **HIGH_VOLATILITY** - Large swings, high risk/reward
- **PANIC** - Extreme fear, capitulation zone

---

## ⚙️ Current Behavior (v1.0.0)

### **Free Tier:**
- Signals updated every 5 minutes
- 4-hour delay on all setups
- Best-effort availability
- No authentication required

### **Paid Tier:**
- Real-time when triggers occur
- Signals based on active trading system state
- Updates every 30-60 seconds
- API key authentication required

### **Known Limitations:**

Signal availability depends on the underlying trading system state. When the system is actively monitoring markets, signals update regularly. During system maintenance or between active trading sessions, signal updates may be delayed.

**Upcoming in v1.1:** We're implementing a global trigger log that will ensure 100% consistent signal delivery regardless of trading system state. This will provide more reliable real-time signals for paid tier users.

**Workaround for now:** Free tier users are unaffected (4h delay built-in). Paid tier users will see signals within 30-60 seconds of trigger detection under normal conditions.

---

## 🎯 How to Use This Data

### Pre-Trade Filter

```bash
# Check regime before entering trades
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
# Check if Cremonix ML found a high-probability setup
setup=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.setup.exists')

if [ "$setup" == "true" ]; then
  combo=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.setup.combo_id')
  score=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json" | jq -r '.btc.setup.score')
  echo "🎯 Setup detected: $combo (score: $score)"
fi
```

---

## 🤖 For Autonomous Agents

### Auto-Subscribe (Lightning)

Agents can subscribe programmatically:

```bash
# Create subscription
curl -X POST https://app.cremonix.com/api-subscribe/create \
  -H "Content-Type: application/json" \
  -d '{
    "user_type": "agent",
    "tier": "paid",
    "payment_method": "lightning",
    "email": "agent@mycompany.com"
  }'

# Returns Lightning invoice
# Agent pays invoice
# Poll for API key:

curl https://app.cremonix.com/api-subscribe/status/{subscription_id}

# When paid, returns:
# {"status": "active", "api_key": "crem_live_..."}
```

See full agent guide: https://docs.cremonix.com/openclaw-agents

---

## ❓ FAQ

### **Q: How often is the data updated?**
**A:** 
- Free tier: Every 5 minutes (but 4h delayed)
- Paid tier: Every 30 seconds (real-time)

### **Q: Can I use the free tier commercially?**
**A:** Yes! Free tier has no usage restrictions.

### **Q: Do I need to install anything?**
**A:** No. Just curl the endpoint. Works in any OpenClaw agent.

### **Q: What if I want to cancel paid tier?**
**A:** 
- Lightning: Just don't pay the next monthly invoice
- Card: Cancel via billing portal at app.cremonix.com/billing

### **Q: Is there a trial period?**
**A:** The free tier IS the trial! Use it as long as you want. Upgrade when you need real-time.

### **Q: Can I share my API key?**
**A:** No. One key per subscription. Sharing may result in suspension.

---

## 📚 More Info

- **Website:** https://cremonix.com
- **Docs:** https://docs.cremonix.com/openclaw
- **Blog:** https://blog.cremonix.com
- **Support:** support@cremonix.com
- **Upgrade:** https://app.cremonix.com/api-subscribe

---

## 🔐 Security

- Free tier: No authentication, public endpoint
- Paid tier: API keys encrypted at rest, transmitted via HTTPS only
- Never share your API key in logs or public repos

---

**Built by Cremonix** - Systematic BTC/ETH trading since 2024 🚀
