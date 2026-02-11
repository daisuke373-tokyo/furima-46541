const pay = () => {
  const form = document.getElementById('purchase_address_form');
  if (!form) return;

  const payjp = Payjp('pk_test_9663206946485df0c793aefe'); // ←ここに公開鍵を貼り付ける
  const elements = payjp.elements();
  
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        // エラーハンドリング
      } else {
        const token = response.id;
        const renderDom = document.getElementById('purchase_address_form');
        const tokenObj = `<input value=${token} name='token' type='hidden'>`;
        renderDom.insertAdjacentHTML('beforeend', tokenObj);

      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById('purchase_address_form').submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
