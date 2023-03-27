// Change color to indicate that plugin is running
// document.querySelector(".base-wrapper").style.background = "#E6DA9D";

browser.runtime.sendMessage({ type: "native", message: "getPasscode" }).then((response) => {
    console.log("Received passcode: ");
    console.log(response);

    if (typeof response !== "string") {
        return;
    }

    if (response === "") {
        return;
    }

    document.querySelector(".base-wrapper").style.background = "#A2E391";

    document.querySelector('select[name="device"]').value = "token";
    document.querySelector('#passcode').click();

    document.querySelector('input[name="passcode"]').value = response.toString();
    document.querySelector('#passcode').click();
});
