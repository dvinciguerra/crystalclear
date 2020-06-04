<script>
  import { onMount } from 'svelte'
  import { format } from 'date-fns'

  import { website, resourceUrl } from '../data'
  import { questions, username } from '../stores'
  import Question from '../components/Question.svelte'
  import PageTitle from '../components/PageTitle.svelte'

  let ws
  let questionContent = ''

  onMount(async () => {
    ws = new WebSocket(`ws://${resourceUrl}/event/stream`)

    ws.onopen = () => console.log('CrystalClear stream is running...')

    ws.onclose = () => console.log('CrystalClear stream is closed...')

    ws.onmessage = (message) => {
      console.log(`websocket message: ${message.data}`)

      const question = JSON.parse(message.data)
      questions.add(question)
    }

    const client = await fetch(`http://${resourceUrl}/event/questions`)
    const payload = await client.json()
    questions.set(payload.questions)
  })

  const onQuestionSubmit = () => {
    const question = {
      createdAt: format(new Date(), 'yyyy-MM-dd HH:mm:ss'),
      content: questionContent,
      username: $username,
    }

    questions.add(question)
    ws.send(JSON.stringify(question))
    questionContent = ''

    console.log(question)
  }

  const onEntrePressed = (event) => {
    if (event.keyCode === 13) {
      event.preventDefault()
      onQuestionSubmit()
    }
  }
</script>

<style>
  .input-question {
    padding-right: 100px;
    resize: none;
    line-height: 90px;
    max-height: 100px;
    overflow: hidden;
  }
  .input-question::-moz-placeholder {
    /* Mozilla Firefox 19+ */
    line-height: 90px;
  }
  .input-question::-webkit-input-placeholder {
    /* Webkit */
    line-height: 100px;
  }
  .input-question:-ms-input-placeholder {
    /* IE */
    line-height: 100px;
  }
  .btn-send-question {
    float: right;
    position: relative;
    margin-top: -65px;
    margin-right: 20px;
  }
</style>

<svelte:head>
  <title>{website.title} - Home</title>
</svelte:head>

<section id="questions" class="container">
  <PageTitle title="Question & Answers" />

  <div class="row mt-4">
    <div class="col-md-12">
      <div class="card">
        <div class="card-body">
          <div class="card-body">
            <textarea
              bind:value={questionContent}
              on:keypress={onEntrePressed}
              class="form-control input-question"
              placeholder="Type your question..."
              autocomplete="none" />
            <button
              on:click|preventDefault={onQuestionSubmit}
              class="btn btn-outline-primary btn-send-question">
              <i class="fa fa-marker" />
              Share
            </button>
            <small class="form-text text-muted">
              <i class="fa fa-info-circle" />
              Ask something to the Speaker and press "Share" or Enter key to send!
            </small>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row mt-4">
    <div class="col-md-10">
      <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
          <a
            class="nav-link active"
            id="pills-home-tab"
            data-toggle="pill"
            href="#pills-home"
            role="tab">
            Recent Questions
          </a>
        </li>
      </ul>
    </div>
    <div class="col-md-2 text-right">
      <small class="navbar-text text-muted pull-right">
        {$questions && $questions.length} questions
      </small>
    </div>
  </div>

  <div class="row mt-4">
    {#each $questions as question}
      <Question {question} />
    {/each}
  </div>

</section>
