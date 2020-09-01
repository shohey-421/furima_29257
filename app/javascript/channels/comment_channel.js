import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div class="comment">
                    <div class="post-user">
                      ${data.content.user}：
                    </div>
                   <div class="post-text">
                      ${data.content.text}
                    （${data.content.date}）
                   </div>
                  </div>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment-text');
    comments.insertAdjacentHTML('beforeend', html);
    newComment.value='';
  }
});
