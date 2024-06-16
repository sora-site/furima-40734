const pay = () => {
  // コントローラー環境変数で公開鍵情報を取得
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey)
  // elementsインスタンスを作成
  const elements = payjp.elements();
  // 入力フォームを作成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  // 要素のid属性を指定し、指定した要素をelementインスタンスが情報を持つフォームと置き換える
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  // form要素を指定
  const form = document.getElementById('charge-form')
  // formを送信した際イベント発火
  form.addEventListener("submit", (e) => {
    // カード番号に関するelementインスタンスを用いてトークンを生成
    payjp.createToken(numberElement).then(function (response) {
      if(response.error){

      }else{
        // レスポンスよりtokenを取得
        const token = response.id;
        // form要素
        const renderDom = document.getElementById("charge-form");
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // フォームの中に作成したinput要素を追加
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // token以外のクレジットカード情報を削除（カード番号・有効期限・CVC）
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      // form要素(埋め込んだトークン情報)をサーバー側へ送信
      document.getElementById("charge-form").submit();
    })
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);