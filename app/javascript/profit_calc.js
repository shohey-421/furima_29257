if (document.URL.match(/items/) && (document.URL.match(/new/) || document.URL.match( /edit/ ))) {

function profit_calc() {
  const item_price = document.getElementById("item-price");
  item_price.addEventListener("input",function(e) {
    const tax_form = document.getElementById("add-tax-price");
    const profit_form = document.getElementById("profit");
    const tax = 0.1;
    const price = item_price.value;

    if (price == "") {
      tax_form.innerHTML = 0;
      profit_form.innerHTML = 0;
     } else {
      const add_tax = Math.ceil( parseInt(price, 10) * tax);
      tax_form.innerHTML = add_tax;
      const profit = price - add_tax;
      profit_form.innerHTML = profit;
     }
  })
  }
  window.addEventListener("load", profit_calc)
}