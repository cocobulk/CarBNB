import { Controller } from "@hotwired/stimulus";
import { EthereumProvider } from "@walletconnect/ethereum-provider";
import Web3 from "web3";


export default class extends Controller {
  static values = {
    projectId: String,
    alchemy: String,
  };
  static targets = ["connect", "pay", "book", "address"];

  // ethereumProvider; // @dev For wallet connect functions.
  accounts;

  web3 = new Web3(
      new Web3.providers.HttpProvider(
        `https://eth-sepolia.g.alchemy.com/v2/${this.alchemyValue}}`,
      ),
    );
  connect() {
    this.bookTarget.disabled = true;
    console.log("WalletConnectController");
    if (typeof window.ethereum !== "undefined") {
      console.log("Metamask Detected");
    } else {
      console.log("Metamask not found");
    }
    // this.#initializeProvider(); // @dev For wallet connect functions.
  }

  connectWallet(e) {
    e.preventDefault();
    console.log("connectWallet");
    this.#permissions();
  }

  pay(e) {
    e.preventDefault();
    this.#sendEth();
  }

  // @dev This does not function, not sure why.
  // isPaid(e) {
  //   e.preventDefault();
  //   try {
  //     if (this.bookTarget.disabled == false) {
  //       console.log("paid");
  //     } else {
  //       console.log("clicked disabled button");
  //       let container = document.getElementById("flash");
  //       container.innerText = "Please pay first";
  //       container.style.display = "block";
  //       setTimeout(() => {
  //         container.style.display = "none";
  //         container.removeChild(div);
  //       }, 800);
  //     }
  //   } catch (error) {
  //     console.log(error.message);
  //   }
  // }

  // @dev Class method to initialize the provider for wallet connect. Not used currently but functional.
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
          exodus: "https://www.exodus.com/brand/img/logo.svg",
        },
      },
      chains: [11155111],
      methods: ["eth_sendTransaction", "personal_sign"],
      events: ["chainChanged", "accountsChanged"],
      metadata: {
        name: "Car BNB",
        description: "Rent cars with crypto",
        url: "https://car-bnb-scott.herokuapp.com/",
        icons: ["/app/assets/images/logo.png"],
      },
    });
    // Do something with the initialized provider, such as saving it to a variable or using it in your application
    console.log(this.ethereumProvider);
  }

  async #permissions() {
    const reg = /\b(\w{6})\w+(\w{4})\b/g;
    this.accounts = await ethereum.request({ method: "eth_requestAccounts" });
    this.connectTarget.innerText = "Connected";
    this.addressTarget.innerText = ethereum.selectedAddress.replace(
      reg,
      "$1****$2"
    );
    console.log("Eth Accounts: ", this.accounts);
    // @dev This is the event listener for the connect button wallet connect.
    // await this.ethereumProvider.connect();
    // await this.ethereumProvider.on("connect", (accounts) => {
    //   console.log(accounts);
    // });
  }

  async #sendEth() {

    try {
      // const limit = Web3.eth
      // .estimateGas({
      //   from: this.accounts[0],
      //   to: "0x2f318C334780961FB129D2a6c30D0763d9a5C970",
      //   value: web3.utils.toWei("0.001"),
      // });

      const txHash = await ethereum.request({
        method: "eth_sendTransaction",
        params: [
          {
            from: this.accounts[0],
            to: "0x2f318C334780961FB129D2a6c30D0763d9a5C970",
            value: web3.utils.numberToHex(
              web3.utils.toWei("0.000001", "ether")
            ),
            // gas: web3.utils.numberToHex(limit),
            gas: web3.utils.toHex(
              web3.utils.toWei("2", "gwei")
            ),
            maxPriorityFeePerGas: web3.utils.toHex(
              web3.utils.toWei("2", "gwei")
            ),
          },
        ],
        // @dev This is the initial way with hard-coded hex values from docs. Use web3-utils.
        // params: [
        //   {
        //     from: this.accounts[0], // The user's active address.
        //     to: "0x2f318C334780961FB129D2a6c30D0763d9a5C970", // Required except during contract publications.
        //     value: "0xE8D4A51000", // Only required to send ether to the recipient from the initiating external account.
        //     gasPrice: "0x09184e72a000", // Customizable by the user during MetaMask confirmation.
        //     gas: "0x2710", // Customizable by the user during MetaMask confirmation.
        //   },
        // ],
      });
      console.log(txHash);
      if (txHash) {
        this.payTarget.innerText = "Paid";
        this.bookTarget.disabled = false;
      }
    } catch (error) {
      console.log(error.message);
    }
  }
}
