const pay = () => {
  const form = document.getElementById('purchase_address_form');
  if (!form) return;

  const publicKey = gon.payjp_public_key;
  if (!publicKey) return;

  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        // エラーハンドリング
      } else {
        const token = response.id;
        const tokenInput = document.getElementById('purchase_address_token');
        tokenInput.value = token;
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById('purchase_address_form').submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
