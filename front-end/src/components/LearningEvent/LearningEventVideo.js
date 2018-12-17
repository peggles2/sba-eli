import React, {Component} from "react";
import ReactPlayer from "react-player";
import { Button, Header, Icon } from "semantic-ui-react";
import { findDOMNode } from "react-dom";
import Duration from "./LearningEventVideo/Duration";
import screenfull from "screenfull";
import "./Slider.css"

export default class LearningEventVideo extends Component {
  state = {
    url: "http://movietrailers.apple.com/movies/marvel/avengers-endgame/avengers-endgame-trailer-1_a720p.m4v",
    playing: false,
    volume: 0.8,
    muted: false,
    pip: false,
    played: 0,
    loaded: 0,
    duration: 0,
    playbbackRate: 1.0,
    loop: false,
    height: 480,
    width: 848
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
    this.setState({ seeking: true })
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

  onClickFullscreen = () => {
    screenfull.request(findDOMNode(this.player))
  }

  ref = (player) => {
    this.player = player
  }

  render() {
    const { url, playing, volume, muted,  pip, played, loaded, duration, playbackRate, loop, height, width } = this.state
    const vidLength = <Duration seconds={duration} />;

    const playerControlsStyle = {
      width: width,
      marginTop: '-5px',
      overflow: 'auto',
      padding: '15px 20px 15px 20px',
      backgroundColor: '#000000',
      opacity: 0.9
    };

    const seekStyle = {
      width: '385px',
      marginLeft: '20px'
    };

    const volStyle = {
      width: '50px'
    };

    const durationStyle = {
      marginLeft: '25px',
      marginRight: '25px',
      color: '#FFFFFF',
    }

    return(
      <div>
        <em>Exercise ({vidLength} minutes)</em>
        <div className="player-wrapper">
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
        <div className="player-controls" style={playerControlsStyle}>
          <Button.Group basic color='black' icon>
            <Button onClick={this.playPause} aria-label="play">
              {playing ? <Icon name='pause' size='big' inverted color='grey'/> : <Icon name='play' size='big' inverted color='grey' />}
            </Button>
          <Button icon basic onClick={this.toggleMuted} aria-label="mute">
            {muted ? <Icon name='volume off' size='big' inverted color='grey'/> : <Icon name='volume up' size='big' inverted color='grey'/>}
          </Button>
          </Button.Group>
          <input type='range' min={0} max={1} step='any'
            value={volume}
            onChange={this.setVolume}
            style={volStyle}
            class="volumeSlider"
          />
          <span className="seek-bar" style={{ marginTop: '15px'}}>
            <input
              type='range' min={0} max={1} step='any'
              value={played}
              onMouseDown={this.onSeekMouseDown}
              onChange={this.onSeekChange}
              onMouseUp={this.onSeekMouseUp}
              style={seekStyle}
              class="slider"
            />
            <span style={durationStyle}><b><Duration seconds={duration * played} /></b> / <Duration seconds={duration} /></span>
          </span>
          <Button.Group basic icon color='black' floated='right'>
            <Button aria-label='closed captioning'>
              <Icon name='closed captioning' size='big' color='orange'/>
            </Button>
            <Button onClick={this.onClickFullscreen} aria-label='fullscreen'>
              <Icon name='expand' size='big' inverted color='grey' />
            </Button>
          </Button.Group>
        </div>
      </div>
    )
  }
}
