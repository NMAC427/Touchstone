browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
    
    // Relay message to native app
    if (request.type === "native") {
        browser.runtime.sendNativeMessage("application.id", request.message).then((response) => {
            console.log("Received sendNativeMessage response:");
            console.log(response);
            
            sendResponse(response);
        });
        
        return true;
    } else {
        sendResponse(null);
    }
    
    return false;
});
