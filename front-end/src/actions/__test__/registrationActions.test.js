import mockAxios from "axios";
import { registerUser, loginUser, logoutUser } from '../registrationActions'

describe("registerUser", () => {
  it("should pass on data to axios correctly", () => {
    mockAxios.post.mockReset();
    mockAxios.post.mockImplementationOnce(() => {
      Promise.resolve({
        data: { results: 'results' }
      })
    })

    const result = registerUser('userData');

    expect(result.type).toEqual('REGISTER');
    expect(mockAxios.post).toHaveBeenCalledTimes(1);
    expect(mockAxios.post).toHaveBeenCalledWith(
      process.env.REACT_APP_SERVICE_HOST + "/sign_up",
      'userData');
  });
});

describe("loginUser", () => {
  it("should pass on data to axios correctly", () => {
    mockAxios.post.mockReset();
    mockAxios.post.mockImplementationOnce(() => {
      Promise.resolve({
        data: { results: 'results' }
      })
    })

    const result = loginUser('userData');

    expect(result.type).toEqual('LOGIN');
    expect(mockAxios.post).toHaveBeenCalledTimes(1);
    expect(mockAxios.post).toHaveBeenCalledWith(
      process.env.REACT_APP_SERVICE_HOST + "/session",
      'userData');
  });
});

describe("logoutUser", () => {
  it("should pass on data to axios correctly", () => {
    mockAxios.delete.mockReset();
    mockAxios.post.mockImplementationOnce(() => {
      Promise.resolve({
        data: { results: 'results' }
      })
    })

    const result = logoutUser('userData');

    expect(result.type).toEqual('LOGOUT');
    expect(mockAxios.delete).toHaveBeenCalledTimes(1);
    expect(mockAxios.delete).toHaveBeenCalledWith(
      process.env.REACT_APP_SERVICE_HOST + "/session",
      {"headers": {"AUTHORIZATION": "userData"}});
  });
});
