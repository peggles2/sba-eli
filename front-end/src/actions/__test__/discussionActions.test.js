import mockAxios from "axios";
import {getDiscussion, postDiscussion} from '../discussionActions'

describe("Get a discussion from the service layer", () => {
  it("should query based on content type and id", () => {
    mockAxios.post.mockReset();
    mockAxios.post.mockImplementationOnce(() => {
      Promise.resolve({
        data: {
          "post_count": 4,
          "replies": [{
            "id": 4,
            "content_type": "comment",
            "user_img": null,
            "user_name": "system",
            "timestamp": "2019-01-08T16:49:42.936Z",
            "user_title": null,
            "post_number": 1,
            "reply_to_post_number": null,
            "body": "\u003cp\u003eThese terms govern use of the Internet forum at \u003ca href=\"//forum-dev.eli.fearless.tech\"\u003ehttp://forum-dev.eli.fearless.tech\u003c/a\u003e.  To use the forum, you must agree to these terms with ELI, the company that runs the forum.\u003c/p\u003e\n\u003cp\u003eThe company may offer other products and services, under different terms.  These terms apply only to use of the forum.\u003c/p\u003e",
            "replies": []
          },
            {
              "id": 5,
              "content_type": "comment",
              "user_img": null,
              "user_name": "system",
              "timestamp": "2019-01-08T16:49:43.214Z",
              "user_title": null,
              "post_number": 2,
              "reply_to_post_number": null,
              "body": "\u003cp\u003eEdit the first post in this topic to change the contents of the Terms of Service page.\u003c/p\u003e",
              "replies": [{
                "id": 80,
                "content_type": "comment",
                "user_img": null,
                "user_name": "Dev User",
                "timestamp": "2019-02-01T15:59:29.933Z",
                "user_title": "",
                "post_number": 4,
                "reply_to_post_number": 2,
                "body": "\u003cp\u003ethis is a reply to the second post, what does it look like?\u003c/p\u003e",
                "replies": []
              }]
            },
            {
              "id": 79,
              "content_type": "comment",
              "user_img": null,
              "user_name": "Dev User",
              "timestamp": "2019-02-01T15:59:14.992Z",
              "user_title": "",
              "post_number": 3,
              "reply_to_post_number": null,
              "body": "\u003cp\u003eThis is a reply to the top level comment\u003c/p\u003e",
              "replies": []
            }
          ]
        }
      })
    })

    const content_type = "infographic"
    const content_id = "8"
    const result = getDiscussion(content_type, content_id);

    expect(result.type).toEqual('GET_DISCUSSION');
    expect(mockAxios.get).toHaveBeenCalledTimes(1);
    expect(mockAxios.get).toHaveBeenCalledWith(
        process.env.REACT_APP_SERVICE_HOST + "/discussions/" + content_type + "/" + content_id);
  });
});
