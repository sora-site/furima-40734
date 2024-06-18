function post() {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitInput = document.getElementById("profit");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue * 0.9);

    taxOutput.innerHTML = `<span id='add-tax-price'>${tax}</span>`;
    profitInput.innerHTML = `<span id='profit'>${profit}</span>`;
  });
};

window.addEventListener('turbo:load', post);
window.addEventListener("turbo:render", post);
