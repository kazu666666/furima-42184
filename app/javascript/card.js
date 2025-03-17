document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
   
    const response = await payjp.createToken(numberElement);
    if (response.error) {
      console.error("PAY.JP トークンエラー:", response.error);
      return;
    }

    const tokenInput = document.createElement("input");
    tokenInput.setAttribute("type", "hidden");
    tokenInput.setAttribute("name", "token");
    tokenInput.setAttribute("value", response.id);
    form.appendChild(tokenInput);

    numberElement.clear();
    expiryElement.clear();
    cvcElement.clear();

    form.submit();
  });
});

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);