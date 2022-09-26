from brownie import transfer_token
from scripts.helpful_scripts import get_account


def deploy_transfer():
    account = get_account()
    deploy_transfer_token = transfer_token.deploy({"from": account})
    print(deploy_transfer_token)


def main():
    deploy_transfer()
