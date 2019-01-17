export default {
  get: jest.fn(() => Promise.resolve({ 'get': 'result'})),
  post: jest.fn(() => Promise.resolve({ 'post': 'result' })),
  delete: jest.fn(() => Promise.resolve({ 'delete': 'result'}))
}