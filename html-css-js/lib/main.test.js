import { describe, it, expect } from 'vitest';
import MyClass from './main.js';

describe('MyClass', () => {

  it('talk() returns "ok"', () => {
    const myClass = new MyClass();

    expect(myClass.talk()).toBe('ok');
  });

});
