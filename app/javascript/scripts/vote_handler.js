class VoteHandler {
  constructor(voteButtons) {
    this.voteButtons = voteButtons;
  }

  init() {
    this.handleVoteRequests();
  }

  generateDataForRequest (form) {
    const data = new URLSearchParams();
    for (const pair of new FormData(form)) {
        data.append(pair[0], pair[1]);
    }
    return data;
  }

  handleVoteRequests () {
    for (let voteButton of this.voteButtons) {
      voteButton.addEventListener('click', event => {
        event.preventDefault();
    
        fetch(voteButton.form.action, {
          method: 'post',
          body: this.generateDataForRequest(voteButton.form)
        })
          .then(res => res.json())
          .then(data => {
            const answerId = voteButton.dataset['answerId'];
            let currentAnswerVoteCount = document.getElementById('vote-count-' + answerId);
            currentAnswerVoteCount.textContent = data.vote_count;
    
            if (voteButton.dataset.type === 'upvote') {
              document.getElementById('downvote-button-' + answerId).classList.remove('downvote');
              voteButton.classList.toggle('upvote');
            } else {
              document.getElementById('upvote-button-' + answerId).classList.remove('upvote');
              voteButton.classList.toggle('downvote');
            }
          })
          .catch(() => {});
      });
    }
  }
};

const voteHandler = new VoteHandler(document.getElementsByClassName('vote-button'));
voteHandler.init();
