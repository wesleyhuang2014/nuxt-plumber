<template>
  <div>

    <!-- grid-container -->
    <div class="grid-container">
      <div class="grid-x grid-padding-x">
        <div class="medium-12 cell">
          <img src="~/assets/img/logo.png" alt="Nuxt.js Logo" class="logo float-center" />
        </div>
      </div>
    </div>
    <!-- grid-container -->

    <!-- grid-container -->
    <div class="grid-container">
      <div class="grid-x grid-padding-x">
        <div class="medium-12 cell">
          <div class="text-center">
            <h1>{{ message }}</h1>
            <p>This is new test.</p>
            <nuxt-link to="/randomforest" class="button">病理预测</nuxt-link>
          </div>
        </div>
      </div>
    </div>
    <!-- grid-container -->

  </div>
</template>

<script>
import axios from '~/plugins/axios'

export default {
  async mounted () {
    // Initiate foundation.
    // Must do it after Vue has rendered the view.
    //$(document).foundation()
  },
  async asyncData () {
    var {data} = await axios.get('/')
    var data = data.data

    var props = {
      message: data.message,
    }
    return props
  },
  head () {
    return {
      title: '病理预测',
      meta: [
        { hid: 'description', name: 'description', content: 'Home page' }
      ],
    }
  }
}
</script>

<style>
h1 {
  font-size: 40px;
}

p {
  font-size: 20px;
}
</style>
