# GitHub Repository Setup Guide

**Quick guide to publish Cremonix Signals to GitHub and submit to ClawHub**

---

## 🚀 Quick Start (5 Minutes)

### **Step 1: Initialize Git Repository**

```bash
cd /home/btcbot/clawd/teams/team-008/clawhub-package

# Initialize repo
git init

# Add all files
git add .

# First commit
git commit -m "Initial release: Cremonix Signals v1.0.0

- Free tier with 4h delayed signals
- Paid tier with real-time signals ($25/month)
- Lightning and card payment support
- Agent autonomous subscription
- Comprehensive documentation"
```

---

### **Step 2: Create GitHub Repository**

**Option A: Via GitHub CLI (if installed):**
```bash
gh repo create cremonix/openclaw-signals --public --source=. --remote=origin
gh repo edit --add-topic openclaw --add-topic trading --add-topic btc --add-topic eth --add-topic ml --add-topic signals
```

**Option B: Via Web:**
1. Go to https://github.com/new
2. Repository name: `openclaw-signals`
3. Description: "BTC/ETH regime intelligence + ML-powered signals for OpenClaw agents"
4. Public repository
5. **Don't** initialize with README (we have one)
6. Click "Create repository"

---

### **Step 3: Push to GitHub**

```bash
# Add remote (use your actual GitHub URL)
git remote add origin git@github.com:cremonix/openclaw-signals.git

# Push code
git branch -M main
git push -u origin main

# Create v1.0.0 tag
git tag -a v1.0.0 -m "Release v1.0.0: Initial public release"
git push origin v1.0.0
```

---

### **Step 4: Configure Repository**

**Add Topics (for discoverability):**
Go to repo settings or use:
```bash
gh repo edit --add-topic openclaw
gh repo edit --add-topic trading
gh repo edit --add-topic bitcoin
gh repo edit --add-topic ethereum
gh repo edit --add-topic machine-learning
gh repo edit --add-topic ai-agents
gh repo edit --add-topic trading-signals
gh repo edit --add-topic cryptocurrency
```

**Create Release:**
1. Go to https://github.com/cremonix/openclaw-signals/releases/new
2. Tag: `v1.0.0`
3. Title: `Cremonix Signals v1.0.0 - Initial Release`
4. Description: Copy from CHANGELOG.md
5. Click "Publish release"

---

### **Step 5: Submit to ClawHub**

**Method 1: Direct GitHub Integration**
1. Go to https://clawhub.com/submit
2. Select "Import from GitHub"
3. Paste: `https://github.com/cremonix/openclaw-signals`
4. ClawHub will auto-import

**Method 2: Manual Submission**
1. Download latest release ZIP from GitHub
2. Upload to ClawHub submission form
3. Fill in metadata (auto-populated from SKILL.md)

---

## 📝 Repository Metadata

**Add to GitHub repo description:**
```
BTC/ETH regime intelligence + ML-powered entry signals from 36-model ensemble. 
Systematic edge for disciplined traders. Free tier (4h delayed) + paid tier 
(real-time, $25/mo). Built for OpenClaw AI agents.
```

**Add to About section:**
- Website: https://cremonix.com
- Topics: `openclaw`, `trading`, `btc`, `eth`, `ml`, `ai-agents`
- Releases: Enable
- Packages: Disable
- Environments: Disable

---

## 🔒 Security Checklist

Before pushing to GitHub:

- [x] No API keys in code
- [x] No hardcoded credentials
- [x] .gitignore includes sensitive patterns
- [x] Examples use placeholder emails
- [x] Documentation has no real user data
- [x] LICENSE file included (MIT)

---

## 📦 What Gets Published

```
openclaw-signals/
├── .gitignore                  # Ignore sensitive files
├── CHANGELOG.md                # Version history
├── LICENSE                     # MIT License
├── README.md                   # User-facing docs
├── SKILL.md                    # Main skill documentation
├── cremonix-signals.sh         # Wrapper script
├── examples/
│   ├── basic-usage.sh
│   ├── pre-trade-filter.sh
│   └── agent-subscribe.py
├── SUBMISSION_CHECKLIST.md     # (optional, can exclude)
├── PACKAGE_SUMMARY.md          # (optional, can exclude)
└── GITHUB_SETUP.md             # (this file, can exclude)
```

**Optional files** (can add to .gitignore if you don't want them public):
- SUBMISSION_CHECKLIST.md
- PACKAGE_SUMMARY.md
- GITHUB_SETUP.md

---

## 🎯 Post-Publication

### **Update Links**

After GitHub repo is live, update:

1. **SKILL.md frontmatter:**
   ```yaml
   repository: https://github.com/cremonix/openclaw-signals
   ```
   (Already done! ✅)

2. **README.md contributing section:**
   Add link to GitHub issues

3. **Cremonix website:**
   Add "OpenClaw Skill" link

---

### **Promote on Social**

**Twitter:**
```
🚀 Just launched: Cremonix Signals for @OpenClaw agents!

36 ML models → BTC/ETH regime intelligence + entry signals

🆓 Free tier (4h delayed)
💎 Paid tier ($25/mo real-time)

Agents can subscribe autonomously via Lightning ⚡

GitHub: https://github.com/cremonix/openclaw-signals
```

**Discord (OpenClaw server):**
```
Hey everyone! 👋

Just published Cremonix Signals - an OpenClaw skill for BTC/ETH trading intelligence.

Features:
- 36-model ML ensemble for regime detection
- High-probability entry signals
- Free tier + paid tier ($25/mo)
- Agent-native (autonomous subscription)

Check it out: https://github.com/cremonix/openclaw-signals
```

**Reddit (r/OpenClaw, r/Bitcoin):**
Title: "Built an OpenClaw skill for ML-powered BTC/ETH trading signals"
Body: Link to GitHub + brief description

---

## 🔄 Future Updates

When you release v1.1.0:

```bash
# Make changes
vim SKILL.md
vim CHANGELOG.md

# Commit
git add .
git commit -m "v1.1.0: Global trigger log for consistent signals"

# Tag
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin main --tags

# Create GitHub release
# ClawHub auto-syncs (if GitHub integration enabled)
```

---

## ❓ Troubleshooting

**Issue: "Permission denied (publickey)"**
```bash
# Check SSH key
ssh -T git@github.com

# If fails, use HTTPS instead
git remote set-url origin https://github.com/cremonix/openclaw-signals.git
```

**Issue: "Repository not found"**
- Verify you created the repo on GitHub first
- Check you're using the correct organization/username

**Issue: "ClawHub not syncing"**
- GitHub integration may take 5-10 minutes
- Try manual re-sync in ClawHub dashboard
- Or re-submit via web form

---

## ✅ Checklist

- [ ] Git repo initialized
- [ ] GitHub repo created
- [ ] Code pushed to main branch
- [ ] v1.0.0 tag created
- [ ] GitHub release published
- [ ] Topics added to repo
- [ ] Submitted to ClawHub
- [ ] Social media announcements posted

---

**Ready to go!** Follow steps 1-5 above and you'll be live on GitHub + ClawHub in 10 minutes. 🚀
