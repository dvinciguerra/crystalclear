<script>
  import { username } from '../stores'

  let usernameText

  const onUsernameChange = () => username.set(usernameText)
</script>


<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-5">
  <div class="container">
    <a class="navbar-brand" href="/"><strong>Crystal</strong><span class="font-weight-lighter">Clear</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="/">Q&A <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/about">About</a>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <div class="input-group">
          <div class="input-group-prepend">
            <div class="input-group-text">@</div>
          </div>
          <input type="text" bind:value={usernameText} on:change={onUsernameChange} class="form-control" placeholder="Username (optional)">
        </div>
      </form>
    </div>
  </div>
</nav>
