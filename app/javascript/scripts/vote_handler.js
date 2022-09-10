class VoteHandler {
  constructor(container) {
    this.answersContainer = container;
  }

  init() {
    this.answersContainer.addEventListener('click', async event => {
      event.preventDefault();

      if (event.target.classList.contains('vote-button')) {
        const voteButton = event.target;
        const formData = this.generateDataForRequest(voteButton.form);
        const data = await this.handleVoteRequests(voteButton, formData);
        const { 
          dataset: {
            resourceId,
            resourceType,
            buttonType
          }
        } = voteButton;
  
        this.handleVoteButtonClasses(voteButton, resourceId, resourceType, buttonType, data);
      }
    });
  }

  generateDataForRequest(form) {
    const data = new URLSearchParams();
    for (const pair of new FormData(form)) {
        data.append(pair[0], pair[1]);
    }
    return data;
  }

  handleVoteButtonClasses(voteButton, resourceId, resourceType, buttonType, data) {
    let currentAnswerVoteCount = document.getElementById(`vote-count-${resourceId}-${resourceType}`);
    currentAnswerVoteCount.textContent = data.vote_count;

    if (buttonType === 'upvote') {
      document.getElementById(`downvote-button-${resourceId}-${resourceType}`).classList.remove('downvote');
      voteButton.classList.toggle('upvote');
    } else {
      document.getElementById(`upvote-button-${resourceId}-${resourceType}`).classList.remove('upvote');
      voteButton.classList.toggle('downvote');
    }
  }

  async handleVoteRequests(voteButton, formData) {
    const res = await fetch(voteButton.form.action, {
      method: 'post',
      body: formData
    });

    return await res.json();
  }
};

const voteHandler = new VoteHandler(document.querySelector('[data-ref="answers-container"]'));
voteHandler.init();
