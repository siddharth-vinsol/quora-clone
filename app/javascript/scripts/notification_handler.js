var initPage = function() {
  const NOTIFICATION_ENDPOINT = 'http://127.0.0.1:3000/notifications';
  const POLLING_INTERVAL = 30000;

  class NotificationHandler {
    constructor(notificationBellContainer, notificationContainer, notificationList) {
      this.notificationBellContainer = notificationBellContainer;
      this.notificationContainer = notificationContainer;
      this.notificationList = notificationList;
    }

    init() {
      this.notificationBellContainer.click(() => {
        this.notificationBellContainer.children()[0].classList.add('hide');
        this.notificationContainer.toggleClass('hide');
        this.fetchUnreadNotifications();
        this.markNotificationsAsSent();
      })

      this.pollNotifications();
    }

    pollNotifications() {
      this.fetchUnreadNotifications();
      setInterval(() => {
        this.fetchUnsentNotifications();
      }, POLLING_INTERVAL)
    }

    fetchUnsentNotifications() {
      $.get(NOTIFICATION_ENDPOINT + '/unsent')
        .then(data => {
          const { notifications, status } = data;
          if (notifications.length >= 1) {
            this.notificationBellContainer.children()[0].classList.remove('hide');
          }
        });
    }

    fetchUnreadNotifications() {
      $.get(NOTIFICATION_ENDPOINT + '/unread')
        .then(data => {
          const { notifications, status } = data;
          this.notificationList.empty();
          notifications.forEach(element => {
            this.notificationList.append(`
              <div class="notification highlight">
                <a href="${element.redirect_link}">
                  <div class="notification-text">${element.content}</div>
                  <div class="notification-text">${moment(element.created_at).fromNow()}</div>
                </a>
              </div>
            `);
          });
        });
    }

    markNotificationsAsSent() {
      $.post(NOTIFICATION_ENDPOINT + '/mark_sent')
        .then(() => {})
    }
  }

  let notificationHandler = new NotificationHandler($('*[data-ref="notification-bell-container"]'), $('*[data-ref="notification-container"]'), $('*[data-ref="notification-list"]'));
  notificationHandler.init();
}

initPage();
document.addEventListener('turbolinks:load', initPage);
