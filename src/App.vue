<template>
  <div id="app">
    <ul class="colors">
      <li
        class="color"
        v-for="(color, index) in colors"
        :key="index"
        :class="`col--${color.name}`"
      >
        <p
          v-for="(p, index) in [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]"
          :key="`lighter${index}`"
          :class="`lighter${p}`"
          :style="`background: ${lighter(color.value, p)}`"
        >
          {{ `lighter${p}` }} {{ lighter(color.value, p) }}
        </p>
        <p
          :style="`background: #${color.value}; padding: 20px 0px;`"
          @click="showName[color.name] = !showName[color.name]"
        >
          <input
            type="text"
            v-model="color.value"
            style="
              background: transparent;
              border: 0;
              text-align: center;
              color: white;
              width: 100%;
              height: 100%;
              display: flex;
              padding: 20px 0;
            "
            @blur="showName[color.name] = !showName[color.name]"
            @mouseout="showName[color.name] = !showName[color.name]"
          />
          <!--
          {{ color.color.hex || color.color }}
          <sketch-picker v-model="color.color" v-if="showName[color.name]"/>
          -->
        </p>
        <p
          v-for="(p, index) in [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]"
          :key="`darker${index}`"
          :class="`darker${p}`"
          :style="`background: ${darker(color.value, p)}`"
        >
          {{ `darker${p}` }} {{ darker(color.value, p) }}
        </p>
      </li>
    </ul>
  </div>
</template>

<script>
import { mix } from "./mix";

export default {
  name: "App",
  data() {
    return {
      showName: {
        main: false,
        secondary: false,
        accent: false,
        success: false,
        danger: false,
        warning: false,
      },
      colors: [
        { name: "main", value: "2D9ee0", color: "#2D9ee0" },
        { name: "secondary", value: "26255C", color: "#26255C" },
        { name: "accent", value: "E68C1E", color: "#E68C1E" },
        { name: "success", value: "5BB058", color: "#5BB058" },
        { name: "danger", value: "D63E55", color: "#D63E55" },
        { name: "warning", value: "F5C72F", color: "#F5C72F" },
        { name: "ground", value: "D4D4D4", color: "#D4D4D4" },
      ],
    };
  },
  computed: {},
  methods: {
    updateValue() {
      console.log("updateValue", this);
    },
    mColor(color) {
      const hex =
        this.colors.find((c) => c.name === color).color.hex ||
        this.colors.find((c) => c.name === color).color;
      return hex;
    },
    lighter(color, percentage) {
      return mix(color, "ffffff", percentage);
    },
    darker(color, percentage) {
      return mix("000000", color, percentage);
    },
  },
};
</script>

<style lang="scss">
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

$color: #2D9ee0;
$light: lighten($color, 15%);
$dark: darken($color, 10%);
$lighter: lighten($color, 30%);
$darker: darken($color, 30%);

ul {
  list-style: none;
  display: flex;
  li {
    margin: 0 14px;
  }
}

body {
  text-align: center;
  padding-top: 1em;
}

p {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 1em;
  width: 134px;
  height: 36px;
  border-radius: 4px;
  padding: 0;
  display: flex;
  -webkit-margin-before: 4px;
  -webkit-margin-after: 4px;
  -webkit-margin-start: 0px;
  -webkit-margin-end: 0px;
  align-items: center;
  justify-content: center;
}

@function darker($color, $percentage) {
  @return mix(black, $color, $percentage);
}

@function lighter($color, $percentage) {
  @return mix($color, white, $percentage);
}

$main-color: #2D9ee0;

$map: (
  main: #2D9ee0,
  secondary: #26255C,
  accent: #E68C1E,
  success: #5BB058,
  danger: #D63E55,
  warning: #F5C72F,
);
.colors {
  .color {
    @each $c, $val in $map {
      &.col--#{$c} {
        color: white;
        @each $t in 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0 {
          p {
            background: $val;
          }
          p.lighter#{$t} {
            background: lighter($val, $t);
          }
        }
        @each $t in 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0 {
          p.darker#{$t} {
            background: darker($val, $t);
          }
        }
      }
    }
  }
}
</style>
