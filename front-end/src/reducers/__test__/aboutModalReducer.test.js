import reducer from '../aboutModalReducer'

describe("aboutModalReducer", () => {
  it("should toggle state to false", () => {
    expect(reducer({
      show: true
    }, { type: 'TOGGLE_ABOUT_MODAL', payload: false })).toEqual({
      show: false
    });
  });
  
  it("should toggle state to true", () => {
    expect(reducer({
      show: false
    }, { type: 'TOGGLE_ABOUT_MODAL', payload: true })).toEqual({
      show: true
    });
  });
});
