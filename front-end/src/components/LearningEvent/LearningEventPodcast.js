import React, {Component} from "react";
import ReactPlayer from "react-player";
import { Button, Grid, Header} from "semantic-ui-react";
import Duration from "./LearningEventVideo/Duration";
import "./Slider.scss";

export default class LearningEventPodcast extends Component {
  state = {
    url: this.props.url,
    playing: false,
    volume: 0.8,
    muted: false,
    pip: false,
    played: 0,
    loaded: 0,
    duration: 0,
    playbackRate: 1.0,
    loop: false,
    height: '100%',
    width: '100%'
  }

  playPause = () => {
    this.setState({ playing: !this.state.playing })
  }

  setVolume = (e) => {
    this.setState({volume: parseFloat(e.target.value) })
  }

  toggleMuted = () => {
    this.setState({ muted: !this.state.muted })
  }

  onSeekMouseDown = (e) => {
    this.setState({ seeking: true})
  }

  onSeekChange = (e) => {
    this.setState({ played: parseFloat(e.target.value) })
  }

  onSeekMouseUp = (e) => {
    this.setState({ seeking: false })
    this.player.seekTo(parseFloat(e.target.value))
  }

  onProgress = (state) => {
    if(!this.state.seeking) {
      this.setState(state)
    }
  }

  onDuration = (duration) => {
    this.setState({ duration })
  }

  ref = (player) => {
    this.player = player
  }

  render() {
    const { url, playing, volume, muted,  pip, played, duration, playbackRate, loop, height, width } = this.state

    return (
      <div>
        <div className="podcast-wrapper">
          <ReactPlayer
            ref={this.ref}
            url={url}
            pip={pip}
            playing= {playing}
            loop={loop}
            playbackRate={playbackRate}
            volume={volume}
            muted={muted}
            height={height}
            width={width}
            onProgress={this.onProgress}
            onDuration={this.onDuration}
          />
        </div>
        <div className="podcast-controls">
          <Grid centered>
            <Grid.Column width={1}>
              <Button
                circular
                basic
                icon={playing ? 'pause' : 'play'}
                size="massive"
                onClick={this.playPause}
                aria-label={playing ? 'pause' : 'play' }
              />
            </Grid.Column>
            <Grid.Column width={12}>
              <Grid.Row>
                <Header as='h2'> {this.props.event.title}</Header>
              </Grid.Row>
              <Grid.Row>
                <span className="podcast-duration">
                  <b><Duration seconds={duration * played} /></b>
                </span>
                <input
                  type='range' min={0} max={1} step='any'
                  value={played}
                  onMouseDown={this.onSeekMouseDown}
                  onChange={this.onSeekChange}
                  onMouseUp={this.onSeekMouseUp}
                  className="slider"
                  aria-label="seek"
                />
                <span className="podcast-duration"><Duration seconds={duration} /></span>
                <Button
                  circular
                  basic
                  icon={muted ? 'volume off' : 'volume up'}
                  onClick={this.toggleMuted}
                  aria-label={muted ? "mute" : "unmute"}
                />
                <input type='range' min={0} max={1} step='any'
                  value={volume}
                  onChange={this.setVolume}
                  className="volumeSlider"
                  aria-label="volume slider"
                />
              </Grid.Row>
            </Grid.Column>
          </Grid>
        </div>
      </div>
    )
  }
}
