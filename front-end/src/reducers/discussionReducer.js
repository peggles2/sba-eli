const defaultValue = {
    replies: [
        {
          id: 123,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Georgina Foreman",
          timestamp: "September 1, 2018 1pm",
          user_title: "Small Business Owner Extraordinaire",
          body: "Nested replies. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
          replies: [
            {
              id: 5678,
              content_type: "comment",
              user_img: "http://picsum.photos/45?random",
              user_name: "Penelope Grant",
              timestamp: "January 1, 2018 1pm",
              user_title: "Small Business Person",
              body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
              replies: []
            },
            {
              id: 9,
              content_type: "comment",
              user_img: "http://picsum.photos/45?random",
              user_name: "Andrea Lopez",
              timestamp: "September 14, 2018 11:05pm",
              user_title: "Business Owner",
              body: "Gummi bears dessert muffin tootsie roll powder brownie fruitcake",
              replies: []
            }
          ]
        },
        {
          id: 234,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Regina Miles",
          timestamp: "September 1, 2018 1:05pm",
          user_title: "Medium Business Owner",
          body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
          replies: []
        }
      ]
    
  };
  
  export default function reducer(state=defaultValue, action) {
    switch(action.type) {
      case 'GET_DISCUSSION':
        return {...state, replies: []} 
      case 'GET_DISCUSSION_FAILURE':
        return {...state, replies: []} 
      case 'GET_DISCUSSION_FULFILLED':
        return {...state, replies: action.payload.data} 
      default:
        break;
    };
    
    return state;
  }