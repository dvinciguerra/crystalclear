<script>
  import { website } from '../data'
	import Navbar from '../components/Navbar.svelte';
</script>

<svelte:head>
  <title>{website.title}</title>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,700,800" />
</svelte:head>

<Navbar />

<main>
	<slot />
</main>