import { toggleModal } from '../aboutModalActions'

describe("aboutModalActions", () => {
  it("should toggle correctly", () => {
    expect(toggleModal(true)).toEqual({
      type: 'TOGGLE_ABOUT_MODAL',
      payload: true
    });
    
    expect(toggleModal(false)).toEqual({
      type: 'TOGGLE_ABOUT_MODAL',
      payload: false
    });
  });
});
