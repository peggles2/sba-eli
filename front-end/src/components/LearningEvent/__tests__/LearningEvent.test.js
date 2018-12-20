import React from "react";
import {Header} from "semantic-ui-react";
import LearningEvent from "../LearningEvent";
import LearningEventManager from "../LearningEventManager";
import MetaTags from "../../SEO/MetaTags";
import { shallow, mount } from "enzyme";

describe("LearningEvent", () => {
  
  it("should render meta tags with Learning Event specific information", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const title = "learning event title"
    const desc = "learning event description"
    const learningEvent= { title: title, description: desc};
    
    const wrapper = shallow(<LearningEvent match={match} />);
    wrapper.instance().setState({learningEvent});

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find('title').text()).toBe(title);
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe(desc);
    //TODO: add Canonical URL validation when we have final urls
    //expect(metaWrapper.find("link[rel='canonical']").props().href).toBe("https://sba.gov/eli")
  });

  it("should render a single h1 and it should display the event title", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const title = "learning event title"
    const desc = "learning event description"
    const learningEvent = { title: title, description: desc};
    
    const wrapper = mount(<LearningEvent match={match} />);
    wrapper.instance().setState({learningEvent});

    expect(wrapper.find("h1").exists()).toBe(true);
    expect(wrapper.find("h1").length).toEqual(1);
    expect(wrapper.find("h1").text()).toEqual(title);
  });

  it("should render a <LearningEventManager>", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const wrapper = mount(<LearningEvent match={match} />);

    expect(wrapper.find(LearningEventManager).exists()).toBe(true);
  });
});
