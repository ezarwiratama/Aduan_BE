const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Contact = sequelize.define('Contact', {
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  no_handphone: {
    type: DataTypes.STRING,
    allowNull: false
  },
  bidang: {
    type: DataTypes.TEXT,
    allowNull: false
  },
}, {
  timestamps: false
});

module.exports = Contact;
