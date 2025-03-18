document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault(); 
    console.log("");

    let token = null;
    try {
      const response = await payjp.createToken(numberElement);
      if (!response.error) {
        token = response.id;
      }
    } catch (e) {
      console.error("", e);
    }

    const tokenInput = document.createElement("input");
    tokenInput.setAttribute("type", "hidden");
    tokenInput.setAttribute("name", "token");
    tokenInput.setAttribute("value", token || ""); 
    form.appendChild(tokenInput);

    console.log("", token);

    numberElement.clear();
    expiryElement.clear();
    cvcElement.clear();

    console.log("");

    console.log("");
    form.submit();
  });
});