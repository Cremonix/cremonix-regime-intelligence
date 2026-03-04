#!/usr/bin/env python3
"""
Example: Autonomous agent subscription to Cremonix Signals API

This shows how an AI agent can:
1. Discover the paid tier from free feed metadata
2. Ask human for budget approval
3. Subscribe autonomously via Lightning
4. Poll for payment confirmation
5. Auto-configure OpenClaw with API key
"""

import requests
import json
import time
import os
from pathlib import Path

# Agent configuration
AGENT_EMAIL = os.getenv("AGENT_EMAIL", "agent@example.com")
BUDGET_LIMIT = 30  # Agent can spend up to $30/month
AUTO_APPROVE = False  # Set to True to skip human approval


def discover_upgrade():
    """Step 1: Discover upgrade from free feed metadata"""
    print("🔍 Checking Cremonix free feed...")
    
    response = requests.get("https://blog.cremonix.com/feeds/cremonix-free.json")
    feed = response.json()
    
    if feed.get('tier') == 'free' and feed.get('upgrade', {}).get('available'):
        upgrade = feed['upgrade']
        print(f"\n💎 Upgrade discovered:")
        print(f"   Name: {upgrade['name']}")
        print(f"   Price: ${upgrade['price']['amount']}/{upgrade['price']['interval']}")
        print(f"   Features: {', '.join(upgrade['features'][:3])}...")
        return upgrade
    
    print("❌ No upgrade available")
    return None


def ask_human_approval(upgrade):
    """Step 2: Ask human for budget approval"""
    if AUTO_APPROVE:
        print("✅ Auto-approval enabled")
        return True
    
    price = upgrade['price']['amount']
    
    if price > BUDGET_LIMIT:
        print(f"❌ Price ${price} exceeds budget limit ${BUDGET_LIMIT}")
        return False
    
    print(f"\n🤖 Agent requesting approval:")
    print(f"   Subscription: {upgrade['name']}")
    print(f"   Cost: ${price}/month")
    print(f"   Budget available: ${BUDGET_LIMIT}/month")
    
    approval = input("\n   Approve subscription? (yes/no): ").lower()
    return approval in ['yes', 'y']


def subscribe(upgrade):
    """Step 3: Subscribe via Lightning API"""
    print("\n⚡ Creating Lightning subscription...")
    
    response = requests.post(
        upgrade['agent_example']['url'],
        headers=upgrade['agent_example']['headers'],
        json={
            **upgrade['agent_example']['body'],
            'email': AGENT_EMAIL
        }
    )
    
    subscription = response.json()
    
    if 'error' in subscription:
        print(f"❌ Error: {subscription['error']}")
        return None
    
    print(f"✅ Subscription created: {subscription['subscription_id']}")
    print(f"\n💰 Lightning Invoice:")
    print(f"   Amount: {subscription['payment_options']['lightning']['amount_sats']} sats (~$25)")
    print(f"   Invoice: {subscription['payment_options']['lightning']['invoice'][:50]}...")
    print(f"\n📋 Pay this invoice to activate subscription")
    
    return subscription


def wait_for_payment(subscription_id):
    """Step 4: Poll for payment confirmation"""
    print(f"\n⏳ Waiting for payment...")
    status_url = f"https://app.cremonix.com/api-subscribe/status/{subscription_id}"
    
    max_attempts = 60  # 3 minutes
    for attempt in range(max_attempts):
        time.sleep(3)
        
        response = requests.get(status_url)
        status = response.json()
        
        if status.get('status') == 'active':
            print(f"\n✅ Payment confirmed!")
            return status.get('api_key')
        
        if attempt % 10 == 0:
            print(f"   Still waiting... ({attempt * 3}s elapsed)")
    
    print("❌ Payment timeout - no payment received within 3 minutes")
    return None


def configure_openclaw(api_key):
    """Step 5: Auto-configure OpenClaw"""
    print(f"\n🔧 Configuring OpenClaw...")
    
    config_path = Path.home() / ".openclaw" / "openclaw.json"
    
    # Load existing config
    if config_path.exists():
        config = json.loads(config_path.read_text())
    else:
        config = {}
    
    # Add Cremonix plugin config
    if 'plugins' not in config:
        config['plugins'] = {}
    if 'entries' not in config['plugins']:
        config['plugins']['entries'] = {}
    
    config['plugins']['entries']['cremonix'] = {
        'enabled': True,
        'config': {
            'apiKey': api_key
        }
    }
    
    # Write updated config
    config_path.parent.mkdir(parents=True, exist_ok=True)
    config_path.write_text(json.dumps(config, indent=2))
    
    print(f"✅ OpenClaw configured at {config_path}")
    print(f"   API key: {api_key[:20]}...")
    print(f"\n🎉 Subscription complete! Real-time signals now active.")


def main():
    print("🤖 Cremonix Agent Subscription Example\n")
    
    # Step 1: Discover upgrade
    upgrade = discover_upgrade()
    if not upgrade:
        return
    
    # Step 2: Get approval
    if not ask_human_approval(upgrade):
        print("❌ Subscription declined")
        return
    
    # Step 3: Subscribe
    subscription = subscribe(upgrade)
    if not subscription:
        return
    
    # Step 4: Wait for payment
    api_key = wait_for_payment(subscription['subscription_id'])
    if not api_key:
        return
    
    # Step 5: Configure OpenClaw
    configure_openclaw(api_key)


if __name__ == "__main__":
    main()
