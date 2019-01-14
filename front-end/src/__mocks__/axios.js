export default {
  post: jest.fn(() => Promise.resolve({ 'post': 'result' })),
  delete: jest.fn(() => Promise.resolve({ 'delete': 'result'}))
}