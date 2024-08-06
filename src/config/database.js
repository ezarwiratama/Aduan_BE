const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('whatsapp_message', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});

module.exports = sequelize;
