class NotificationPopHandler {
  constructor(popupContainer) {
    this.popupContainer = popupContainer;
  }

  init() {
    this.popupContainer.removeClass('hide');
    this.popupContainer.click(() => {
      location.reload()
    })
  }
}

const notificationPopHandler = new NotificationPopHandler($('*[data-ref="pop-up-notification"]'));
