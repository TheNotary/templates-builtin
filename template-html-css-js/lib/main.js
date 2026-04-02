console.log("loaded dependency")

export default class MyClass {
  constructor() {
    this.value = "ok";
  }

  talk() {
    return this.value;
  }
}
