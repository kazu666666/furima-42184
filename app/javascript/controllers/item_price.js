const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxDisplay = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById("profit");

  if (!priceInput || !taxDisplay || !profitDisplay) return; 

  taxDisplay.innerHTML = "0";
  profitDisplay.innerHTML = "0";

  priceInput.addEventListener("input", () => {
    const priceValue = priceInput.value.trim(); 
    const price = parseFloat(priceValue); 

    if (priceValue === "") {
      taxDisplay.innerHTML = "0";
      profitDisplay.innerHTML = "0";
    } else if (!isNaN(price) && price >= 0) {
      const tax = Math.floor(price * 0.1);
      const profit = price - tax; 

      taxDisplay.innerHTML = tax.toLocaleString(); 
      profitDisplay.innerHTML = profit.toLocaleString(); 
    } else {
      taxDisplay.innerHTML = "NaN"; 
      profitDisplay.innerHTML = "NaN"; 
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);