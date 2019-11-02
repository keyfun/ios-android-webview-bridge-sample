function sendDataToApp() {
    var response = {
        data: {
            name: "keyName",
            stringValue: "myValue",
            numberValue: 123
        }
    }
    if (window.DemoWebInterface) {
        // Call Android interface
        window.DemoWebInterface.postMessage(JSON.stringify(response))
      } else if (
        window.webkit &&
        window.webkit.messageHandlers &&
        window.webkit.messageHandlers.demo
      ) {
        // Call iOS interface
        window.webkit.messageHandlers.demo.postMessage(response)
      } else {
        // No Android or iOS interface found
        console.log('No native APIs found.')
        alert('No native APIs found.')
      }
}

