<template>
    <!-- grid-container -->
    <div class="container">

          <form v-on:submit.prevent="submitPredict" id="form-predict">
            <!-- Age	sex	BMI	smoking	drinking	hypertension	T2DM	hyperlipidemia	TC	HDL	TG	LDL	SBP	DBP	FPG	Group -->
            <div class="form-horizontal">
              <div class="halfw">
              <strong class="col-sm-6">年龄:</strong>
              </div>
              <div class="halfw">
                <input name="age" v-model.trim.number="patient.age"/>
              </div>
            </div>

            <div class="form-group">
                <strong class="col-sm-6">性别:</strong>
                <select name="sex" v-model="patient.sex" class="col-sm-6">
                  <option disabled value="0">性别</option>
                  <option value="1">男</option>
                  <option value="2">女</option>
                </select>             
            </div>
 
             <div class="form-group">
                  <strong class="col-sm-6">BMI:</strong>
                  <input name="bmi" v-model.trim.number="patient.bmi" class="col-sm-6" />
             </div>

              <div class="form-group">
                <strong class="col-sm-6">是否吸烟:</strong>
                <select name="smoking" v-model="patient.smoking" class="col-sm-6">
                  <option disabled value="0">吸烟</option>
                  <option value="1">是</option>
                  <option value="2">否</option>
                </select>             
              </div>

             <div class="form-group">
                <strong class="col-sm-6">是否饮酒:</strong>
                  <select name="drinking" v-model="patient.drinking" class="col-sm-6">
                    <option disabled value="0">饮酒</option>
                    <option value="1">是</option>
                    <option value="2">否</option>
                  </select>             
              </div>

              <div class="form-group">
                <strong class="col-sm-6">是否高血压:</strong>
                  <select name="hypertension" v-model="patient.hypertension" class="col-sm-6">
                    <option disabled value="0">高血压</option>
                    <option value="1">是</option>
                    <option value="2">否</option>
                  </select>             
              </div>

              <div class="form-group">
                <strong class="col-sm-6">是否二型糖尿病:</strong>
                  <select name="t2dm" v-model="patient.t2dm" class="col-sm-6">
                    <option disabled value="0">二型糖尿病</option>
                    <option value="1">是</option>
                    <option value="2">否</option>
                  </select>             
              </div>

              <div class="form-group">
                <strong class="col-sm-6">是否高血脂:</strong>
                  <select name="hyperlipidemia" v-model="patient.hyperlipidemia" class="col-sm-6">
                    <option disabled value="0">高血脂</option>
                    <option value="1">是</option>
                    <option value="2">否</option>
                  </select>             
              </div>

              <div class="form-group">
                <strong class="col-sm-6">TC:</strong>
                <input name="tc" v-model.trim.number="patient.tc" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">HDL:</strong>
                <input name="hdl" v-model.trim.number="patient.hdl" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">TG:</strong>
                <input name="tg" v-model.trim.number="patient.tg" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">LDL:</strong>
                <input name="ldl" v-model.trim.number="patient.ldl" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">SBP:</strong>
                <input name="sbp" v-model.trim.number="patient.sbp" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">DBP:</strong>
                <input name="dbp" v-model.trim.number="patient.dbp" class="col-sm-6" />
              </div>

              <div class="form-group">
                <strong class="col-sm-6">FPG:</strong>
                <input name="fpg" v-model.trim.number="patient.fpg" class="col-sm-6" />
              </div>
            <button type="submit" class="button">Submit</button>
          </form>

          <!-- this component will only be rendered on client-side -->
          <!-- no-ssr>
            <p><pre>params: {{ patient }}</pre></p>
          </no-ssr-->
          <div>
            <h1>预测结果</h1>
            <p>{{ group }}</p>
          </div>
  </div>
  <!-- grid-container -->
</template>

<script>
import axios from '~/plugins/axios'
import querystring from 'querystring'
import NoSSR from 'vue-no-ssr'

export default {
  // https://alligator.io/vuejs/hide-no-ssr/
  // https://github.com/egoist/vue-no-ssr
  components: {
    'no-ssr': NoSSR
  },
  async mounted () {
    // Initiate foundation.
    // Must do it after Vue has rendered the view.
    //$(document).foundation()
    //$(this.$el).foundation()

    // Get Z Foundation media query screen size.
    // http://foundation.zurb.com/sites/docs/javascript-utilities.html#mediaquery
    function getZFcurrentMediaQuery () {
      return Foundation.MediaQuery.current
    }

    window.addEventListener('resize', () => {
      var current = getZFcurrentMediaQuery()
      console.log('Screen size: ' + current)
    })

    // https://stackoverflow.com/questions/10328665/how-to-detect-browser-minimize-and-maximize-state-in-javascript
    document.addEventListener('visibilitychange', () => {
      console.log(document.hidden, document.visibilityState)
    }, false)

    // Plot the data as soon as you are mounted.
    this.submitPlot()
  },
  async asyncData() {
    return {
      patient :{
      age: 0,
      sex: '1',
      bmi: 0,
      smoking: '1',
      drinking: '1',
      hypertension: '1',
      t2dm: '1',
      hyperlipidemia: '1',
      tc: 0,
      hdl: 0,
      tg: 0,
      ldl: 0,
      sbp: 0,
      dbp: 0,
      fpg: 0,
      },
      results:[],
    }
  },
  computed: {
    group() {
      if ("data" in this.results) {
        if ("message" in this.results.data){
          if (1 == this.results.data.message) {
            return "否";
          } else {
            return "是";
          }
        }
      }
      return "待定";
    }
  },
  methods: {
    async submitPredict() {
      // Serialize form.
      // https://stackoverflow.com/questions/11661187/form-serialize-javascript-no-framework
      let formData = Array.from(new FormData(document.getElementById('form-predict')).entries(),
           e => e.map(encodeURIComponent).join('=')).join('&')

      // https://012.vuejs.org/guide/forms.html
      let response = await axios({
        method: 'post',
        url: '/randomforest',

        // Stringify the object so you get: plot=scatter&species=setosa
        // https://github.com/axios/axios/issues/350#issuecomment-227270046
        data: querystring.stringify(this.patient),

        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        responseType: ''
      })

      // Handle response image type.
      // https://github.com/axios/axios/issues/513
      this.results = response.data
    },

    async submitPlot() {

    }
  },
  head () {
    return {
      title: 'Nuxt + R',
      meta: [
        { hid: 'description', name: 'description', content: 'Plot page' }
      ],
    }
  }
}
</script>

<style>
h1 {
  font-size: 25px;
}

p {
  font-size: 16px;
}

strong {
  width: 100%;
}

input {
  width: 100%;
}

select {
  width: 100%;
}
halfw {
  width: 50%;
}
</style>
