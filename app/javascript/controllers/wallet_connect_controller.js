import { Controller } from "@hotwired/stimulus";
import { EthereumProvider } from "@walletconnect/ethereum-provider";

export default class extends Controller {
  static values = {
    projectId: String,
  };
  static targets = ["connect", "pay"];

  // ethereumProvider;
  accounts;

  connect() {
    console.log("WalletConnectController");
    if (typeof window.ethereum !== "undefined") {
      console.log("Metamask Detected");
    } else {
      console.log("Metamask not found");
    }
    // this.#initializeProvider();
  }

  connectWallet(e) {
    console.log("connectWallet");
    this.#permissions();
  }

  pay(e) {
    this.#sendEth();
  }

  // @dev Class method to initialize the provider
  async #initializeProvider() {
    this.ethereumProvider = await EthereumProvider.init({
      projectId: this.projectIdValue,
      showQrModal: true,
      qrModalOptions: {
        themeMode: "light",
        desktopWallets: [
          {
            id: "exodus",
            name: "Exodus",
            links: {
              native: "exodus:",
              universal: "https://www.exodus.com/",
            },
          },
        ],
        walletImages: {
          exodus: "app/assets/images/exodus.svg",
        },
      },
      chains: [11155111],
      methods: ["eth_sendTransaction", "personal_sign"],
      events: ["chainChanged", "accountsChanged"],
      metadata: {
        name: "Car BNB",
        description: "Rent cars with crypto",
        url: "https://car-bnb-scott.herokuapp.com/",
        icons: ["https://www.exodus.com/brand/img/logo.svg"],
      },
    });
    // Do something with the initialized provider, such as saving it to a variable or using it in your application
    console.log(this.ethereumProvider);
  }

  async #permissions() {
    this.accounts = await ethereum.request({ method: "eth_requestAccounts" });
    this.connectTarget.innerText = ethereum.selectedAddress;
    console.log("Eth Accounts: ", this.accounts);
    // await this.ethereumProvider.connect();
    // await this.ethereumProvider.on("connect", (accounts) => {
    //   console.log(accounts);
    // });
  }

  async #sendEth() {
    try {
      const txHash = await ethereum.request({
        method: "eth_sendTransaction",
        params: [
          {
            from: this.accounts[0], // The user's active address.
            to: "0xcbc312D8c334f12da50311adD88D38e073a896D9", // Required except during contract publications.
            value: "0xE8D4A51000", // Only required to send ether to the recipient from the initiating external account.
            gasPrice: "0x09184e72a000", // Customizable by the user during MetaMask confirmation.
            gas: "0x2710", // Customizable by the user during MetaMask confirmation.
          },
        ],
      });
      console.log(txHash);
    } catch (error) {
      console.log(error.message);
    }
  }
}
