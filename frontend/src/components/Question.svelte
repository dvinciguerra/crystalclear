<script>
  export let question = {
    username: '',
    createdAt: '',
    content: '',
  }
</script>

<div class="col-md-12 mb-3">
  <div class="card">
    <div class="card-body">
      <div class="media">
        <div class="mr-4">
          <span class="fa-stack fa-2x">
            <i class="fas fa-circle fa-stack-2x" />
            <i class="fas fa-user fa-stack-1x fa-inverse" />
          </span>
        </div>
        <div class="media-body">
          <h5 class="mt-0">
            {question.username}
            <small class="text-muted">{question.createdAt}</small>
          </h5>
          {question.content}
        </div>
      </div>
    </div>
  </div>
</div>
