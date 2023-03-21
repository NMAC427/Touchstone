setTimeout(function() {
    document.querySelector(".base-wrapper").style.background = "blue";

    document.querySelector('select[name="device"]').value = "token";
    document.querySelector('#passcode').click();
    
    browser.runtime.sendMessage({ type: "native", message: "yksoft" }).then((response) => {
        console.log("Received response: ");
        console.log(response);
        document.querySelector('input[name="passcode"]').value = response.toString();
        document.querySelector('#passcode').click();
    });
}, 10);
