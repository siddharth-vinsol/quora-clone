const NOTIFICATION_ENDPOINT = 'http://127.0.0.1:3000/notifications';
const POLLING_INTERVAL = 1000;

class NotificationHandler {
  constructor(notificationBellContainer) {
    this.notificationBellContainer = notificationBellContainer;
  }

  init() {
    this.pollNotifications();
  }

  pollNotifications() {
    setTimeout(() => {
      this.fetchNotifications();
    }, POLLING_INTERVAL)
  }

  fetchNotifications() {
    $.get(NOTIFICATION_ENDPOINT + '/unsent')
      .then(data => {
        const { notifications, status } = data;
        if (notifications.length >= 1) {
          this.notificationBellContainer.children()[0].classList.remove('hide');
        }
      })
  }
}

let notificationHandler = new NotificationHandler($('*[data-ref="notification-bell-container"]'));
notificationHandler.init();
