function fees (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", (k) => {
    const tax = document.getElementById("add-tax-price");
    tax.innerHTML = Math.round(itemPrice.value * 0.1);
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.round(itemPrice.value - Math.round(itemPrice.value * 0.1));
  });
};

window.addEventListener('load', fees);