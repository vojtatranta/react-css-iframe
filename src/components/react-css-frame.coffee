React = require 'react'
ReactDOM = require 'react-dom'
{ div } = React.DOM
Frame = React.createFactory require 'react-frame-component'
assign = require 'object-assign'


ReactCssFrame = React.createClass
  getDefaultProps: ->
    style:
      border: 'none'
    className: ''
    script: ''
    css: null
    id: null

  _getFrame: ->
    return ReactDOM.findDOMNode(@refs.frame)

  componentDidMount: ->
    # NOTE: when iframe refreshes, rerender everything
    @_getFrame().onload = =>
      @forceUpdate()

    @_addScriptsAndCss()

  componentDidUpdate: ->
    @_addScriptsAndCss()

  _addScriptsAndCss: ->
    doc = @_getFrame().contentDocument

    doc.body.className = 'iframe'

    if @props.script
      script = document.createElement('script')
      script.src = @props.script
      doc.body.appendChild(script)

    if @props.css
      link = document.createElement('link')
      link.rel = 'stylesheet'
      link.href = @props.css
      doc.head.appendChild(link)

  render: ->
    Frame assign({}, @props, { ref: 'frame' }),
      @props.children


module.exports = ReactCssFrame
