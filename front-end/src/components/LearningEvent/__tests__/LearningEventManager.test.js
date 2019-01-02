import React from "react";
import LearningEventManager from "../LearningEventManager";
import LearningEventPage from "../LearningEventPage";
import LearningEventVideo from "../LearningEventVideo";
import LearningEventInfoCard from "../LearningEventInfoCard";
import { shallow } from "enzyme";

describe("LearningEventManager", () => {
  it("should render a Page if the learning event is a page", () => {
    const event = {
      type: "Page",
      eventContent: {
        body: "Lorem Ipsum"
      }
    }

    const wrapper = shallow(<LearningEventManager event={event} />)

    const inst = wrapper.instance()
    expect(inst.renderEventContentByType()).toEqual(<LearningEventPage event={event}/>);
  });

  it("should render a video if the learning event file is a video", () => {
    const event = {
      type: "File",
      eventContent: {
        body: "Lorem Ipsum",
        url: "http://www.video.com/video.mp4",
        mime_class: "video"
      }
    }

    const wrapper = shallow(<LearningEventManager event={event} />)
    const url = event.eventContent.url

    const inst = wrapper.instance()
    expect(inst.renderEventContentByType())
      .toEqual(<LearningEventVideo url={url} event={event}/>);
    expect(inst.eventFileManager(event))
      .toEqual(<LearningEventVideo url={url} event={event}/>);
  });

  it("should render a video if the learning event file is a video", () => {
    const event = {
      type: "ExternalUrl",
      external_url: "http://video.com/video.mp4",
    }

    const wrapper = shallow(<LearningEventManager event={event} />)
    const url = event.external_url

    const inst = wrapper.instance()
    expect(inst.renderEventContentByType())
      .toEqual(<LearningEventVideo url={url} event={event}/>);
    expect(inst.eventURLManager(event))
      .toEqual(<LearningEventVideo url={url} event={event}/>);
  });

  it("should render an event info card if video the URL is wrong", () => {
    const event = {
      type: "ExternalUrl",
      external_url: "http://video.com/ha",
    }

    const wrapper = shallow(<LearningEventManager event={event} />)

    const inst = wrapper.instance()
    expect(inst.renderEventContentByType())
      .toEqual(<LearningEventInfoCard event={event}/>);
    expect(inst.eventURLManager(event))
      .toEqual(<LearningEventInfoCard event={event}/>);
  });

  it("should render an event info card if External URL is null", () => {
    const event = {
      type: "ExternalUrl",
      external_url: null 
    }

    const wrapper = shallow(<LearningEventManager event={event} />)

    const inst = wrapper.instance()
    expect(inst.renderEventContentByType())
      .toEqual(<LearningEventInfoCard event={event}/>);
    expect(inst.eventURLManager(event))
      .toEqual(<LearningEventInfoCard event={event}/>);
  });
});
