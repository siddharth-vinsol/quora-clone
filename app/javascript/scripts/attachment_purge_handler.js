const SERVER_URL = 'http://127.0.0.1:3000/questions';

class AttachmentPurgeHandler {
  constructor(removeButton) {
    this.removeButton = removeButton;
  }

  init() {
    this.removeButton.click(() => {
      console.log(this.removeButton.attr('data-permalink'))
      $.ajax({
        url: `${SERVER_URL}/${this.removeButton.attr('data-permalink')}/remove_attachment.html`,
        type: 'DELETE',
        success: () => {
          window.location.reload();
        }
      });
    })
  }
}

const attachmentPurgeHandler = new AttachmentPurgeHandler($(`*[data-ref="attachment-remove-button"]`))
attachmentPurgeHandler.init();
