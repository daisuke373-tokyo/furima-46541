const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput?.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    console.log(addTaxDom);
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = inputValue - Math.floor(inputValue * 0.1);
    console.log(profitDom);
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);